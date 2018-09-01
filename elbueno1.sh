#!/bin/bash

touch white | touch black 

zenity --info --text "\t\t\t\tWARNING!!! \n Cuidado con lo que le metes a tu computadora \nEste programa te ayudara a tener el control sobre los USB y evitar posibles ataques\n\n\t\t\t\tBIENVENIDO!! :)"


#Buscar si la USB ya esta en alguna lista
numserial=$(dmesg|tail -n 15 | egrep Serial | awk '{print $5'})
#zenity --entry --text "$numserial"

if [ $(grep -c $numserial black) -ne 0 ]; then
zenity --info --text "Lo sentimos. Tu usb no se puede ejecutar\n:(\nPruebe de nuevo"
sudo eject /dev/sdb1
sudo umount /dev/sdb1

elif [ $(grep -c $numserial white) -ne 0 ]; then
zenity --info --text "Tu USB esta en la lista blanca lista para usarse"
sudo mount /dev/sdb1
exit 0
#sudo eject /dev/sdb1

else
#Menu de opciones
opc=$(zenity --entry --text "\tHemos detectado una USB  \n\n\tQue desea hacer con ella? \n\n\t\t1) Agregar a lista blanca \n\t\t2) Agregar a lista negra" --entry-text "Opcion: ")

#opc=$(zenity --entry --text "**Firewall USB**\n1)Poner USB en la lista blanca\n2)Poner USB en la lista negra" --entry-text "Opcion")

case $opc in
 (1)
 zenity --info --text "Tu USB se ha agregado con exito a la lista blanca, ya puedes usarlo :)"
 echo "$numserial" >> white
sudo mount /dev/sdb 

exit
;;

(2)
zenity --info --text "Favor de introducir la contraseña del superusuario en la terminal"
echo "$numserial"  >> black
sudo eject /dev/sdb1
sudo umount /dev/sdb1
zenity --info --text "Tu USB se ha agregado con exito a la lista negra"
exit
;;

(*)
zenity --info --text "Opcion invalida"
exit
esac
break;
fi
