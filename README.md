# 💻 Chuleteo vivo 📜

Almacén de scripts y sentencias útiles para cualquier situación!

## JQ / jsonpath regexs

A continuación un grupo de filtros de jq para distintas ocaciones. Estos filtros han sido utilizados en llamadas a la API de Openshift pero en general podrian utilizarse para filtrar salidas JSON.

Ejemplos:
```yaml
oc get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.startTime}{"\n"}{end}'

'{range .items[*]}[{.status.conditions.message}, {.status.conditions.status}] {"\n"}{end}'

'{.items[*]}[{.status.conditions.message}, {.status.conditions.status}] {"\n"}'
'{.items[*].status.conditions[?(@.status=="True")].message}{"\n\n"}'

### Lista las imagenes de los contenedores por PODS
oc get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.containers[*]}{.image}{", "}{end}{end}' | sort

### Lista las imagenes de los contenedores por NAMESPACE
oc/kubectl get pods --namespace <namespace> -o jsonpath="{.items[*].spec.containers[*].image}"

### Muestra informacion de las subredes 
oc/kubectl get networks/cluster -o jsonpath="{.status}" | jq -r '{ "Cluster Network": .clusterNetwork[].cidr, "Service Network": .serviceNetwork[] }'

```
