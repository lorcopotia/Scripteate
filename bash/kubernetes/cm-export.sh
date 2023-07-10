#!/bin/bash

# Es importante crear el fichero configmap_list.txt con el listado de ConfigMaps a exportar
# con el formato nombre_proyecto/nombre_configmap
configmap_list_file="configmap_list.txt"

# Verificar si el archivo de lista de ConfigMaps existe
if [ ! -f "$configmap_list_file" ]; then
  echo "El archivo de lista de ConfigMaps '$configmap_list_file' no existe."
  exit 1
fi

# Iterar a través de cada línea en el archivo de lista de ConfigMaps
while IFS= read -r configmap_line; do
  # Separar el proyecto y el nombre del ConfigMap
  IFS="/" read -r project configmap <<< "$configmap_line"

  # Verificar si el proyecto existe
  if oc project $project > /dev/null 2>&1; then
    echo "Proyecto: $project"

    # Verificar si el ConfigMap existe en el proyecto
    if oc get configmap $configmap -n $project > /dev/null 2>&1; then
      echo "  Exportando ConfigMap: $configmap"
      oc get configmap $configmap -n $project -o yaml > $project-$configmap.yaml
    else
      echo "  El ConfigMap '$configmap' no existe en el proyecto '$project'."
    fi
  else
    echo "El proyecto '$project' no existe."
  fi

  echo "======================================"
done < "$configmap_list_file"
