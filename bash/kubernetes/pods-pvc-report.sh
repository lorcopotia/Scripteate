#!/bin/bash
# Asignar entrada de parametro a variable
patron=$1

# Almacenar el resultado del primer comando en una variable
resultado=$(oc get pods --all-namespaces -o=json | jq -c '.items[] | {name: .metadata.name, namespace: .metadata.namespace, claimName: .spec |  select( has ("volumes") ).volumes[] | select( has ("persistentVolumeClaim") ).persistentVolumeClaim.claimName }')

# Iterar sobre cada línea del resultado
while IFS= read -r linea; do
    # Extraer el valores utilizando 'jq'
    nombre=$(echo "$linea" | jq -r '.name')
    namespace=$(echo "$linea" | jq -r '.namespace')
    claim=$(echo "$linea" | jq -r '.claimName')

    # Ejecutar el segundo comando utilizando el valor de 'claimName' como parámetro
    reporte=$(oc get pvc "$claim" -n "$namespace" -ojson | jq -c '. | {name: .metadata.name, storageClassName: .spec | select( .storageClassName | contains("$patron")).storageClassName }')
    echo "Proyecto : $namespace , $(echo "$reporte" | jq -r '. | "Pod: \(.name), StorageClass: \(.storageClassName)"')"
done <<< "$resultado"
