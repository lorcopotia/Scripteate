# 💻 Chuleteo vivo 📜

Almacén de scripts y sentencias útiles para cualquier situación!

## Manjaro
Comando para chuleta para la instalacion de los paquetes que utilizo:
```
# Actualizar las bd de pacman y el sistema
sudo pacman -Syyu

# En el momento que lo pregunte seleccionar iptables-nft sobre iptables ya que el primero es mas nuevo y tiene mejoras
sudo pacman -S make gcc linux-headers vim code git qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables obs-studio discord samba libxcrypt-compat openssl ansible jq
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

