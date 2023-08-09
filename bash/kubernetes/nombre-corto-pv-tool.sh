#!/bin/bash

# Obtenemos una lista con los nombres de los PVs que deseamos modificar
listaPV=$(oc get pv -o custom-columns=NAME:.metadata.name,SERVER:.spec.nfs.server,ACCESSMODE:.spec.accessModes,CAPACITY:.spec.capacity.storage,NAMESPACE:.spec.claimRef.namespace,CLAIM:.spec.claimRef.name | grep -v "none\|.cartoons.com\|172\|glusterfs\|mig-olympic\|pre-\|dev-\|backup\|cicd" | awk '{print $1}')

# Si necesitamos algun filtro adicional, como por ejemplo: un listado de los que no son de aplicaciones entorno PRODUCTIVO
listaNONPROD=$(oc get pv -o custom-columns=NAME:.metadata.name,SERVER:.spec.nfs.server,ACCESSMODE:.spec.accessModes,STORAGECLASS:.spec.storageClassName,CAPACITY:.spec.capacity.storage,NAMESPACE:.spec.claimRef.namespace,CLAIM:.spec.claimRef.name --no-headers | grep -v "none\|.cartoons.com\|172\|glusterfs\|mig-olympic\|pre-\|dev-\|backup\|cicd" | awk '{print $1}' | grep -v prod)

# Recorremos la lista de PVs y eliminamos del yaml los campos que no necesitamos ej.: las lineas de annotations, resourceVersion, uid, etc
for elem in $listaNONPROD; do
  echo -e "oc get pv -oyaml $elem | sed '4d;5d;6d;7d; /resourceVersion/d; /selfLink/d; /uid/d; /creationTimestamp/d; s/nombre-servidor/&.example.com/; /status/,\$d'  > nombre-corto-new-pvs/$elem-pv.yaml"
  #oc get pv -oyaml $elem | sed '4d;5d;6d;7d; /resourceVersion/d; /selfLink/d; /uid/d; /creationTimestamp/d; s/ops1adlgp01/&.cartoons.com/; /status/,\$d' > nombre-corto-new-pvs/$elem-pv.yaml
done
