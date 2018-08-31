#!/bin/bash

touch white 
touch black

usb=$(dmesg|tail -n 15 | egrep Serial | awk '{print $5'})

umount /run/MULTIBOOT 


