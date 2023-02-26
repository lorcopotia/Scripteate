# Configuracion de Escritorio (Arch linux)

## Añadir los repositorios segun el país y seleccionar los 6 más rápidos:
1. Primeramente instalar el paquete que contiene `rankmirror`
  - `pacman -S pacman-contrib`
  - `curl -s "https://archlinux.org/mirrorlist/?country=FR&country=GB&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 -`

## Impresora
1. Instalar los paquetes necesarios:
  - `pacman -S cups ghostscript gsfonts hplip cups-pdf python-pyqt5`
2. Luego para añadir y configurar la impresora ejecutar:
  - `hp-setup -u`
