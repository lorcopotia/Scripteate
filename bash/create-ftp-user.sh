#!/bin/bash
# Script desarrollado por Duanel Garrido
# 2021

PASS=$(openssl rand -base64 8)  # genera un password de 8 caracteres aleatoriamente
HOME=/mnt/alldisk/disco2

function create_system_ftp_user {
  if [ $(id -u) -eq 0 ]; then
        #read -p "Enter username : " username
        #read -s -p "Enter password : " password
        egrep "^$USER" /etc/passwd >/dev/null
        if [ $? -eq 0 ]; then
                echo "El usuario: $USER ya existe!"
                exit 1
        else
                useradd -m -p "$PASS" -d "$HOME/$USER" $USER
                [ $? -eq 0 ] && echo "Usuario '$USER' ha sido añadido al sistema! con el passwd: '$PASS'" || echo "No se ha podido añadir el usuario al sistema!"
                sed 's/USUARIO/meh/g' /home/dunix/bin/base.conf > /etc/proftpd/conf.d/"$USER".conf
                sleep 2s; systemctl reload proftpd && echo "Servicio FTP a cargado la nueva configuracion. Conectate!"

        fi
  else
        echo "Solo root puede agregar usuarios al sistema."
        exit 2
  fi
}



#######

#!/bin/bash

# Cargar los parametros pasados por linea de comando
while [[ $# -gt 0 ]]
do
        case "$1" in

                -u|--user)
                        USER="$2"
                        shift
                        ;;

                -d|--dir)
                        HOME="$2"
                        shift
                        ;;

                -r|--remove)
                        DEL="$2"
                        userdel $DEL ; rm -f /etc/proftpd/conf.d/"$DEL".conf
                        shift
                        ;;


                --help|*)
                        echo "Parametros:"
                        echo "   -u|--user \"valor\""
                        echo "   -d|--dir \"valor\""
                        echo "   -r|--remove \"valor\""
                        echo "    --help"
                        exit 1
                        ;;
        esac
        shift
done



if [ -z $USER ];
then
  echo "Por favor, indicar los parametros necesarios. Ejecutar con --help para ver ayuda.";
else
  echo "Usuario: $USER"
  echo "Directorio raiz: $HOME/$USER"
  create_system_ftp_user
fi
