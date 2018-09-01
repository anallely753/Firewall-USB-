#!/bin/bash

touch lblanca 
touch lnegra 

zenity --info --text "\t\t\tWARNING!!! \n Cuidado con lo que le metes a tu computadora \n\nEste programa te ayudara a tener el control sobre los USB y evitar posibles ataques\n\n\t\t\t\tBienvenido sr. Usuario :)"

#desmontamos USB automaticamente
#sudo eject /dev/sdb1
#sudo umount /dev/sdb1
 
#Buscar si la USB ya esta en alguna lista
numserial=$(dmesg | tail -n 15 | egrep Serial | awk '{print $6'} )
if grep -i "{$numserial}" lblanca;
then 
	zenity --info --text "blanca"

elif grep -i "{$numserial}" lnegra;
then 	
	zenity --info --text "negra"
	sudo eject /dev/sdb1
	sudo umount /dev/sdb1

else
	#Menu de opciones
	opc=$(zenity --entry --text "\tHemos detectado tu USB \n\n\tQue desea hacer con ella \n\n\t\t1) Agregar a lista blanca \n\t\t2) Agregar a lista negra" --entry-text "Opcion: ")

	case $opc in 

	(1)
	zenity --info --text "Se paso la USB a la lista blanca exitosamente"
	echo "$numserial" >> lblanca
	exit0
	;;
	(2)
	zenity --info --text "Favor de insertar la contraseña del superusuario en la terminal"
	echo "$numserial" >> lnegra
	sudo eject /dev/sdb1
	zenity --info --text "Se paso la USB a la lista negra exitosamente"
        #sudo umount /dev/sdb1
	exit 
	;;
	(*)
	zenity --info --text "otra plis"
	exit
	;;
	esac
	fi
