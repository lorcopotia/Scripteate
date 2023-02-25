#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34"
WHITE="\e[97m"
ENDCOLOR="\e[0m"
BOLDRED="\e[1;${RED}"
BOLDGREEN="\e[1;${GREEN}m"
BOLDBLUE="\e[1;${BLUE}m"
ITALICRED="\e[3;${RED}m"
ITALICGREEN="\e[3;${GREEN}m"
ITALICBLUE="\e[3;${BLUE}m"

echo -e "${BOLDBLUE}> SETTING DSLR as webcam.${ENDCOLOR}"

CONF_CONTENT="alias dslr-webcam v4l2loopback\noptions v4l2loopback exclusive_caps=1 max_buffer=2"

function create-dslr-files {
    # do dangerous stuff
    echo -e "${BOLDBLUE}> Creating module for DSLR. You must run manjaro-isntall-packages.sh script first.${ENDCOLOR}"
    sudo echo "dslr-webcam" >> /etc/modprobe.d/dslr_webcam

    echo -e "${BOLDBLUE}> Creating files for loading module at boot. ${BOLDRED}Done.${ENDCOLOR}"
    sudo echo -e "$CONF_CONTENT" > "/etc/modprobe.d/dslr-webcam.conf"

    echo -e "${BOLDBLUE}> For using the webcam run the following command:${ENDCOLOR}"
    echo -e "${WHITE}> gphoto2 --stdout --capture-movie | ffmpeg -hwaccel nvdec -c:v mjpeg_cuvid -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0.${ENDCOLOR}"
}


while true; do
    read -p "Did you run manjaro-isntall-packages.sh script first?" yn
    case $yn in
        [Yy]* ) create-dslr-files; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
exit 0