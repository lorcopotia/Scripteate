# Bash

- La funcion del fichero process-file-when-uploaded.sh es de procesar un fichero cuando es copiado a un directorio especifico. Para mas detalles ver comentarios en el script.

Primeramente es necesario instalar inotify-tools y el servidor de FTP y luego copiar el fichero de configuracion de este directorio en la ruta para ello y darle permisos adecuados a la carpeta.

```shell
sudo apt-get install inotify-tools proftpd

```

- El fichero proftpd-ftpuser-access.conf es un ejemplo de configuracion de ProFTPd como complemento del script anterior.


