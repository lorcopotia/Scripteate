#!/usr/bin/env bash

### Colors ##
ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"

### Color Functions ##

greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }
fn_goodafternoon() { echo; echo "Good afternoon."; }
fn_goodmorning() { echo; echo "Good morning."; }
fn_bye() { echo "Bye bye."; exit 0; }
fn_fail() { echo "Wrong option." exit 1; }

agregar-usuario() {
    echo -ne "Escriba ej.: pepito /mnt/home/de/pepito : "
    read -r details
    if [ $# -lt 2 ] && [ $(id -u) -eq 0 ]; then
        USUARIO=$1
        RUTA_HOME=$2
        PASS=$(openssl rand -base64 12)

        egrep "^$USUARIO" /etc/passwd >/dev/null
        if [ $? -eq 0 ]; then
                echo "El usuario: $USUARIO ya existe!"
                exit 1
        else
            useradd -m -p "$PASS" -d "$RUTA_HOME" $USUARIO
            [ $? -eq 0 ] && echo "Usuario '$USUARIO' ha sido añadido al sistema! con el passwd: '$USUARIO'" || echo "No se ha podido añadir el usuario al sistema!"
            sed -e "s/USUARIO/$USUARIO/g" -e "s/RUTA_HOME/$RUTA_HOME/g" proftpd-ftpuser-access.conf > /etc/proftpd/conf.d/"$USUARIO".conf
            sleep 2s; systemctl reload proftpd && echo "Servicio FTP a cargado la nueva configuracion. Conectate!"

        fi
    else
        echo -ne "
$(redprint 'Eres root? has metido: usuario /ruta/del/home ?? \n')
"
        exit 2
    fi

    exit 1

}

borrar-usuario() {
    echo -ne "Escriba ej.: pepito : "
    read -r details
    if [ $# -lt 1 ] && [ $(id -u) -eq 0 ]; then
        USUARIO=$1
        egrep "^$USUARIO" /etc/passwd >/dev/null

        if [ $? -eq 0 ]; then
            userdel $USUARIO ; rm -f /etc/proftpd/conf.d/"$USUARIO".conf
            echo "El usuario: $USUARIO ha sido eliminado!"
            
        else
            echo -ne "
$(redprint 'El usuario: $USUARIO no existe en el sistema! \n')
"
            exit 1
        fi
    else
        echo -ne "
$(redprint 'Eres root? has metido: usuario /ruta/del/home ?? \n')
"
        exit 2
    fi

    exit 1

}


del-submenu() {
    echo -ne "
$(yellowprint 'SUB-SUBMENU')
$(greenprint '1)') ELIMINAR USUARIO
$(blueprint '3)') Go Back to ADD-SUBMENU
$(magentaprint '4)') Go Back to MAIN MENU
$(redprint '0)') Exit

Choose an option:  "
    read -r ans
    case $ans in
    1)
        borrar-usuario
        del-submenu
        ;;
    3)
        add-submenu
        ;;
    4)
        mainmenu
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

add-submenu() {
    echo -ne "
$(blueprint 'AGREGAR USUARIO SUBMENU')
$(greenprint '1)') Agregar: usuario /ruta/de/home
$(magentaprint '2)') Ir al Menu principal
$(redprint '0)') Salir
Choose an option:  "
    read -r ans
    case $ans in
    1)
        agregar-usuario
        ;;
    2)
        mainmenu
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

mainmenu() {
    echo -ne "
$(magentaprint 'MENU PRINCIPAL - FTP TOOL')
$(greenprint '1)') AGREGAR USUARIO
$(greenprint '2)') BORRAR USUARIO
$(redprint '0)') Salir
Choose an option:  "
    read -r ans
    case $ans in
    1)
        add-submenu
        mainmenu
        ;;
    2)
        del-submenu
        mainmenu
        ;;
    0)
        fn_bye
        ;;
    *)
        fn_fail
        ;;
    esac
}

mainmenu
