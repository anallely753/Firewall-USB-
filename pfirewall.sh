#!/bin/bash

touch white 
touch black

usb=$(dmesg|tail -n 15 | egrep Serial | awk '{print $5'})

umount /run/MULTIBOOT 

if [ $( egrep --count $usb black) -ne 0];
then
zenity --info --text "Tu USB no se puede ejecutar"

elif [ $( egrep --count $usb white) -ne 0];
then
zenity --info --text "Tu USB esta en la lista blanca\nSe montara para usarse"
mount /dev/sdb /media/usb


