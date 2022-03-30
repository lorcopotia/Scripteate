# Bash

- La función del fichero _process-file-when-uploaded.sh_ es de procesar un fichero cuando es copiado a un directorio específico. Para mas detalles ver comentarios en el script.

Primeramente es necesario instalar _inotify-tools_ y el servidor de FTP y luego copiar el fichero de configuración de este directorio en la ruta para ello y darle permisos adecuados a la carpeta.

```shell
sudo apt-get install inotify-tools proftpd

```

- El fichero _proftpd-ftpuser-access.conf_ es un ejemplo de configuración de ProFTPd como complemento del script anterior.


