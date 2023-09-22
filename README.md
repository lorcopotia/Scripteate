# 💻 Chuleteo vivo 📜

Almacén de scripts y sentencias útiles para cualquier situación!

## Manjaro
Comando para chuleta para la instalacion de los paquetes que utilizo:
```
# Actualizar las bd de pacman y el sistema
sudo pacman -Syyu

# En el momento que lo pregunte seleccionar iptables-nft sobre iptables ya que el primero es mas nuevo y tiene mejoras
sudo pacman -S make gcc linux-headers vim code git qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables obs-studio discord samba
```

Configurar samba */etc/samba/smb.conf*
```
[global]
   workgroup = MANJARO
   server string = Manjaro Samba Server
   server role = standalone server
   log file = /var/log/samba/log.%m
   max log size = 50
   guest account = nobody
   map to guest = Bad Password
   
   min protocol = SMB2
   max protocol = SMB3

[public]
   path = /srv/samba/share-name
   valid users = USERNAME
   public = yes
   writable = yes
   printable = no
```
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
