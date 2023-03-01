# Configuracion de Escritorio (Arch linux)

## Añadir los repositorios segun el país y seleccionar los 6 más rápidos:
1. Primeramente instalar el paquete que contiene `rankmirror`
  - `pacman -S pacman-contrib`
  - `curl -s "https://archlinux.org/mirrorlist/?country=FR&country=GB&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 -`

## Impresora
1. Instalar los paquetes necesarios:
  - `pacman -S cups ghostscript gsfonts hplip cups-pdf python-pyqt5 sane simple-scan`
2. Luego para añadir y configurar la impresora ejecutar:
  - `hp-setup -u` o `hp-setup -i`
3. Habilitar los servicios e iniciarlos:
  - `sudo systemctl enable cups.service`
  - `sudo systemctl start cups.service`
4. Agregar nuestro usuario al grupo lp y al grupo scanner:
  - `sudo usermod -aG lp <user>`
  - `sudo usermod -aG scanner <user>`

## Escaneamos 
1. Ejecutamos el siguiente comando para localizar el scanner:
- `sudo sane-find-scanner`
2. Una vez que lo encuentra, hay que proceder a descomentar una linea de sane:
- `sudo sed -i '/hpaio/s/^#//g' /etc/sane.d/dll.conf`

        ### Tips and tricks
        To comment line containing specific string with sed, simply do:
        sed -i '/<pattern>/s/^/#/g' file
        And to uncomment it:
        sed -i '/<pattern>/s/^#//g' file

3. Probamos el scanner, podemos hacerlo vía terminal:
  - `sudo scanimage -L` o abrimos simple-scan
