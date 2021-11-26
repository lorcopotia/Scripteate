#!/bin/bash
### Consulta a traves de la API el estado de los nodos del CLUSTER
### Seccion de CLUSTER DESARROLLO on Premises

TOKEN_DEV=$(cat /opt/checks/report/tokens/token-awx-desa.txt)
API_DEV_NODES="https://x.x.x.x:6443/api/v1/nodes/"


#nodos_READY=$(kubectl get nodes -o json | jq -r '.items[] | select(.status.conditions[].type=="Ready") | .metadata.name '| wc -l)
NODOS_DEV_READY=$(curl -k -s -X GET -H "Authorization:Bearer $TOKEN_DEV" $API_DEV_NODES | jq -r '.items[] | select( .status.conditions[].status=="True") | .metadata.name' | wc -l)

#nodos_TOTAL=$(kubectl get nodes --no-headers | wc -l)
NODOS_DEV_TOTAL=$(curl -k -s -X GET -H "Authorization:Bearer $TOKEN_DEV" $API_DEV_NODES | jq -r '.items[] | select( .status.conditions[].type=="Ready") | .metadata.name' | wc -l)

let NODOS_DEV_CRIT=$NODOS_DEV_TOTAL-$NODOS_DEV_READY

export NODOS_DEV_READY
export NODOS_DEV_TOTAL
export NODOS_DEV_CRIT


#echo "Nodos Ready: $NODOS_DEV_READY/$NODOS_DEV_TOTAL "
#echo $(( $nodos_READY-1))

### Seccion de CLUSTER PRODUCCION on Premises

TOKEN_PROD=$(cat /opt/checks-logicalis/preventivo/tokens/token-awx-prod.txt)
API_PROD_NODES="https://x.x.x.x:6443/api/v1/nodes/"

NODOS_PROD_READY=$(curl -k -s -X GET -H "Authorization:Bearer $TOKEN_PROD" $API_PROD_NODES | jq -r '.items[] | select( .status.conditions[].status=="True") | .metadata.name' | wc -l)

NODOS_PROD_TOTAL=$(curl -k -s -X GET -H "Authorization:Bearer $TOKEN_PROD" $API_PROD_NODES | jq -r '.items[] | select( .status.conditions[].type=="Ready") | .metadata.name' | wc -l)

let NODOS_PROD_CRIT=$NODOS_PROD_TOTAL-$NODOS_PROD_READY

export NODOS_PROD_READY
export NODOS_PROD_TOTAL
export NODOS_PROD_CRIT

#echo "Nodos Ready: $NODOS_PROD_READY/$NODOS_PROD_TOTAL "

### Seccion de CLUSTER ARO

TOKEN_ARO=$(cat /opt/checks-logicalis/preventivo/tokens/token-awx-aro.txt)
API_ARO_NODES="https://x.x.x.x:6443/api/v1/nodes/"

NODOS_ARO_READY=$(curl -k -s -X GET -H "Authorization:Bearer $TOKEN_ARO" $API_ARO_NODES | jq -r '.items[] | select( .status.conditions[].status=="True") | .metadata.name' | wc -l)

NODOS_ARO_TOTAL=$(curl -k -s -X GET -H "Authorization:Bearer $TOKEN_ARO" $API_ARO_NODES | jq -r '.items[] | select( .status.conditions[].type=="Ready") | .metadata.name' | wc -l)

let NODOS_ARO_CRIT=$NODOS_ARO_TOTAL-$NODOS_ARO_READY

export NODOS_ARO_READY
export NODOS_ARO_TOTAL
export NODOS_ARO_CRIT

#echo "Nodos Ready: $NODOS_ARO_READY/$NODOS_ARO_TOTAL "
