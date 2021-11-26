#!/bin/bash
var="var.sh"
fichero_json="result.json"

token_ARO=$(cat /opt/checks-logicalis/preventivo/tokens/token-awx-aro.txt)
token_DEV=$(cat /opt/checks-logicalis/preventivo/tokens/token-awx-desa.txt)
token_PRO=$(cat /opt/checks-logicalis/preventivo/tokens/token-awx-prod.txt)
url_DEV="https://prometheus-k8s-openshift-monitoring.apps.dev.server/api/v1/query?query="
url_PRO="https://prometheus-k8s-openshift-monitoring.apps.pro.server/api/v1/query?query="
url_ARO="https://prometheus-k8s-openshift-monitoring.apps.cloud.server/api/v1/query?query="
query="(kubelet_volume_stats_used_bytes*100)/kubelet_volume_stats_capacity_bytes"

fecha=`date +"%d%m%Y"`

# Ejecucion script cluster Desarrollo
PV_CRITICAL_DEV=0
PV_WARNING_DEV=0
PV_OK_DEV=0
IP_DEV="10.1.5.139"
curl -k -s -X GET -H "Authorization:Bearer $token_DEV" "$url_DEV$query" | jq -r '.data.result[] |"\(.metric.persistentvolumeclaim) = \(.value[1])"' > $fichero_json
while read -r line
do
        volumen=$(echo $line | awk '{print $1}')
        ocupacion=$(echo $line | awk '{print $3}' | cut -d "." -f 1)
        max=90
        warning=85

        if [ $ocupacion -ge $max ]
        then
                let PV_CRITICAL_DEV=$PV_CRITICAL_DEV+1
        elif [ $ocupacion -ge $warning ]
        then
                let PV_WARNING_DEV=$PV_WARNING_DEV+1
        fi

done < $fichero_json

PV_TOTAL_DEV=$(curl -k -s -X GET -H "Authorization:Bearer $token_DEV" "$url_DEV$query" | jq -r '.data.result[] |"\(.metric.persistentvolumeclaim) = \(.value[1])"'| wc -l)
let PV_TOTAL_OK_DEV=$PV_TOTAL_DEV-$PV_WARNING_DEV-$PV_CRITICAL_DEV
export PV_WARNING_DEV
export PV_CRITICAL_DEV
export PV_TOTAL_OK_DEV



rm -rf $fichero_json

# Ejecucion script cluster Produccion
fichero_json_PROD="resultprod.json"
PV_CRITICAL_PROD=0
PV_WARNING_PROD=0
PV_OK_PROD=0

curl -k -s -X GET -H "Authorization:Bearer $token_PRO" "$url_PRO$query" | jq -r '.data.result[] |"\(.metric.persistentvolumeclaim) = \(.value[1])"' > $fichero_json_PROD
while read -r line
do
        volumen=$(echo $line | awk '{print $1}')
        ocupacion=$(echo $line | awk '{print $3}' | cut -d "." -f 1)
        max=90
        warning=85

        if [ $ocupacion -ge $max ]
        then
                let PV_CRITICAL_PROD=$PV_CRITICAL_PROD+1
        elif [ $ocupacion -ge $warning ]
        then
                let PV_WARNING_PROD=$PV_WARNING_PROD+1
        fi

done < $fichero_json_PROD

PV_TOTAL_PROD=$(curl -k -s -X GET -H "Authorization:Bearer $token_PRO" "$url_PRO$query" | jq -r '.data.result[] |"\(.metric.persistentvolumeclaim) = \(.value[1])"' | wc -l)
let PV_TOTAL_OK_PROD=$PV_TOTAL_PROD-$PV_WARNING_PROD-$PV_CRITICAL_PROD
export PV_WARNING_PROD
export PV_CRITICAL_PROD
export PV_TOTAL_OK_PROD



rm -rf $fichero_json_PROD

# Ejecucion script cluster ARO
fichero_json_ARO="resultAro.json"
PV_CRITICAL_ARO=0
PV_WARNING_ARO=0
PV_OK_ARO=0

curl -k -s -X GET -H "Authorization:Bearer $token_ARO" "$url_ARO$query" | jq -r '.data.result[] |"\(.metric.persistentvolumeclaim) = \(.value[1])"' > $fichero_json_ARO
while read -r line
do
        volumen=$(echo $line | awk '{print $1}')
        ocupacion=$(echo $line | awk '{print $3}' | cut -d "." -f 1)
        max=90
        warning=85

        if [ $ocupacion -ge $max ]
        then
                let PV_CRITICAL_ARO=$PV_CRITICAL_ARO+1
        elif [ $ocupacion -ge $warning ]
        then
                let PV_WARNING_ARO=$PV_WARNING_ARO+1
        fi

done < $fichero_json_ARO

PV_TOTAL_ARO=$(curl -k -s -X GET -H "Authorization:Bearer $token_ARO" "$url_ARO$query" | jq -r '.data.result[] |"\(.metric.persistentvolumeclaim) = \(.value[1])"' | wc -l)
let PV_TOTAL_OK_ARO=$PV_TOTAL_ARO-$PV_WARNING_ARO-$PV_CRITICAL_ARO

export PV_WARNING_ARO
export PV_CRITICAL_ARO
export PV_TOTAL_OK_ARO

rm -rf $fichero_json_ARO
