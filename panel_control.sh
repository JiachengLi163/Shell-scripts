#!/bin/bash -e

# get DP & EDP reg data
DPHDP0="`sudo i2ctransfer -f -y 2 w1@0x15 0x44 r2`"
DPHDP1="`sudo i2ctransfer -f -y 2 w1@0x15 0x45 r2`"
EDPHDP0="`sudo i2ctransfer -f -y 2 w1@0x15 0x46 r2`"
EDPHDP1="`sudo i2ctransfer -f -y 2 w1@0x15 0x47 r2`"

# change the string to array
arr=(${DPHDP0//,/})
arr=(${DPHDP1//,/})
arr=(${EDPHDP0//,/})
arr=(${EDPHDP1//,/})

# String interception
DP0=${DPHDP0: 5: 9}
DP1=${DPHDP1: 5: 9}
EDP0=${EDPHDP0: 5: 9}
EDP1=${EDPHDP1: 5: 9}

#echo $DP0
#echo $DP1
#echo $EDP0
#echo $EDP1

# if DP connect && EDP not connect, close backlight
if [ $DP0 = "0x79" ] && [ $DP1 = "0xdf" ] && [ $EDP0 = "0x48" ] && [ $EDP1 = "0x48" ]
then
	sudo su linaro -c "DISPLAY=:0.0 xrandr --output DP-1 --brightness 0"
	
	echo "control DP backlight successfully!"

fi
