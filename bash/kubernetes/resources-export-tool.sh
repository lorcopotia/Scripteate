#!/bin/bash

# Verifica si se proporcionó el parámetro obligatorio
if [ $# -eq 0 ]; then
    echo "Debe proporcionar el nombre del proyecto para ejecutar este script."
    exit 1
fi

# Asigna el parámetro a una variable
project=$1

# Función para ejecutar una acción específica
ejecutar_accion() {
    echo "Accion de exportar $1 seleccionada. Proyecto: $project"
    # Verificar si el proyecto existe
    if oc project $project > /dev/null 2>&1; then
      echo "Proyecto: $project"

      recurso=$1
      # Obtener listado de recursos
      listado=$(oc get $recurso --no-headers -oyaml -o custom-columns=:.metadata.name -n $project)
      echo $listado

      for elemento in $listado; do
        echo "Ejecutando comando para el elemento: $elemento"
        # Ejecutamos el comando para cada elemento de la lista
        oc get $recurso $elemento -n $project -o yaml > $project-$recurso--$elemento.yaml
      done
    else
      echo "El proyecto '$project' no existe."
    fi
}

# Ciclo del menú
while true; do
    # Muestra las opciones del menú
    echo "------ Menú ------"
    echo "1. Exportar ConfigMaps"
    echo "2. Exportar Secrets"
    echo "3. Exportar Deployments"
    echo "9. Salir"
    echo "-------------------"

    # Solicita al usuario que seleccione una opción
    read -p "Seleccione una opción: " opcion

    # Verifica la opción seleccionada
    case $opcion in
        1)
            ejecutar_accion configmaps
            ;;
        2)
            ejecutar_accion secrets
            ;;
        3)
            ejecutar_accion deployments
            ;;
        9)
            echo "Saliendo del script."
            exit 0
            ;;
        *)
            echo "Opción inválida."
            ;;
    esac
done
