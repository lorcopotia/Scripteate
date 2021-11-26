#!/bin/sh

var="var.sh"
proy_res_ARO="proy-result-ARO.txt"
proy_res_DEV="proy-result-DEV.txt"
proy_res_PRO="proy-result-PRO.txt"

token_ARO=$(cat /opt/checks/report/tokens/token-awx-aro.txt)
token_DEV=$(cat /opt/checks/report/tokens/token-awx-desa.txt)
token_PRO=$(cat /opt/checks/report/tokens/token-awx-prod.txt)

url_ARO="https://x.x.x.x:6443/api/v1/namespaces/"
url_DEV="https://x.x.x.x:6443/api/v1/namespaces/"
url_PRO="https://x.x.x.x:6443/api/v1/namespaces/"

curl -k -s -X GET -H "Authorization:Bearer $token_ARO" "$url_ARO" | jq -r '.items[] |"\(.status.phase)"' > $proy_res_ARO
curl -k -s -X GET -H "Authorization:Bearer $token_DEV" "$url_DEV" | jq -r '.items[] |"\(.status.phase)"' > $proy_res_DEV
curl -k -s -X GET -H "Authorization:Bearer $token_PRO" "$url_PRO" | jq -r '.items[] |"\(.status.phase)"' > $proy_res_PRO

# ARO
proy_cont_critical_ARO=0
while read -r line_ARO
do
        if [ $line_ARO != "Active" ]
        then
                let proy_cont_critical_ARO=$proy_cont_critical_ARO+1
        fi

done < $proy_res_ARO

proy_total_ARO=$(cat $proy_res_ARO | wc -l)


# DEV
proy_cont_critical_DEV=0
while read -r line_DEV
do
        if [ $line_DEV != "Active" ]
        then
                let proy_cont_critical_DEV=$proy_cont_critical_DEV+1
        fi

done < $proy_res_DEV

proy_total_DEV=$(cat $proy_res_DEV | wc -l)


# PRO
proy_cont_critical_PRO=0
while read -r line_PRO
do
        if [ $line_PRO != "Active" ]
        then
                let proy_cont_critical_PRO=$proy_cont_critical_PRO+1
        fi

done < $proy_res_ARO

proy_total_PRO=$(cat $proy_res_PRO | wc -l)


# Exportar variables
export proy_total_ARO
export proy_cont_critical_ARO
export proy_total_DEV
export proy_cont_critical_DEV
export proy_total_PRO
export proy_cont_critical_PRO

# Borrar ficheros
rm -rf $proy_res_ARO $proy_res_DEV $proy_res_PRO
