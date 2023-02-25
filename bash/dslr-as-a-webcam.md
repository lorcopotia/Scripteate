# Using DSLR as a webcam on Arch/Manjaro Linux

Gracias a Ben Chapman y a su publicación [How to Use Your DSLR Camera as a Webcam in Linux](https://www.crackedthecode.co/how-to-use-your-dslr-as-a-webcam-in-linux/) y a [keilmillerjr](https://gist.github.com/keilmillerjr) por compartirla.

## Compatibilidad
[Supported Cameras](http://www.gphoto.org/proj/libgphoto2/support.php)

He hecho las pruebas con:
| Sistema Operativo | Kernel | Cámara |
| ----------- | ----------- | ----------- |
| Arch Linux x86_64 | 6.1.12-arch1-1 | Cannon EOS 77D | 

## Instalación
1. Instalar el kernel headers.
  - `$ sudo pacman -S linux-headers`
2. Instalar las dependencias.
  - `$ sudo pacman -S gphoto2 v4l-utils v4l2loopback-dkms ffmpeg`

## Cargar el módulo de kernel v4l2loopback
Prueba el módulo v4l2loopback cargandolo en el momento.

1. Carga el módulo v4l2loopback ejecutando el comando siguiente: 
  - `$ sudo modprobe v4l2loopback exclusive_caps=1 max_buffers=2`
2. Lista todos los módulos del kernel cargadosy confirma que v4l2loopback está cargado.
  - `$ modinfo v4l2loopback`
  - `$ lsmod`

## Para cargar el módulo automáticamente al inicio
    $ sudo nano /etc/modules-load.d/modules.conf                                    
    # List of modules to load at boot
    dslr-webcam

## Prueba con gphoto2
Connect camera vis usb and turn camera on. Change the following settings on the camera (Canon EOS Rebel T7), else it will not connect to PC via USB.
- Auto power off > Disable
- Wi-Fi/NFC > Disable
```
$ lsusb
$ gphoto2 --auto-detect
$ gphoto2 --summary
$ gphoto2 --abilities
```
If connection is verified via previous commands, try taking an image and saving it to your computer.
```
$ cd ~
$ gphoto2 --capture-image-and-download
```

## Para activar DSLR como webcam
`$ gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0`

El transmisión puede ahora ser reconozida por varias aplicaciones como Cheese, OBS Studio, QT V4L2 test Utility, Shotcut, VLC media playter, etc. Presiona `ctrl + c` para terminar la transmisión.

Si te salta un error (-53: 'Could not claim the USB device') al ejecutar gphoto, matando todos los procesos de gphoto puede resolver el problema: `$ pkill -f gphoto2`.

Puedes crear un alias para no tener que copiar el comando cada vez. Añadelo a `~/.bashrc`, `~/.zshrc`, etc: 
`alias start_dslr='pkill -f gphoto2 && gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0'`

Lo podras utilizar una vez que reinicies la terminal o ejecutes `~/.bashrc` por ejemplo con `$ start_dslr`.
