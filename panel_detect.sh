#!/bin/bash -e

# get DP & eDP reg data
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

DP00=${DPHDP0: 0: 4}
DP01=${DPHDP0: 5: 9}
DP10=${DPHDP1: 0: 4}
DP11=${DPHDP1: 5: 9}
EDP00=${EDPHDP0: 0: 4}
EDP01=${EDPHDP0: 5: 9}
EDP10=${EDPHDP1: 0: 4}
EDP11=${EDPHDP1: 5: 9}

#echo $DP00
#echo $DP01
#echo $DP10
#echo $DP11
#echo $EDP00
#echo $EDP01
#echo $EDP10
#echo $EDP11

# The read voltage value is converted to base 10
let "DP_HPD0=(($DP00 << 8 | $DP01))"
let "DP_HPD1=(($DP10 << 8 | $DP11))"
let "EDP_HPD0=(($EDP00 << 8 | $EDP01))"
let "EDP_HPD1=(($EDP10 << 8 | $EDP11))"

echo "DP_HPD0 voltage is $DP_HPD0"
echo "DP_HPD1 voltage is $DP_HPD1"
echo "EDP_HPD0 voltage is $EDP_HPD0"
echo "EDP_HPD1 voltage is $EDP_HPD1"

echo " Panel HPD ADC table "
echo " DP_HPD0  MIN: 1.09       TYP: 1.21       MAX: 1.33 "
echo " DP_HPD1  MIN: 2.04       TYP: 2.27       MAX: 2.50 "
echo " EDP_HPD0 MIN: 1.57       TYP: 1.74       MAX: 1.91 "
echo " EDP_HDP1 MIN: 2.52       TYP: 2.80       MAX: 3.08 "

echo "DP_HPD0=$DP_HPD0 DP_HPD1=$DP_HPD1 EDP_HPD0=$EDP_HPD0 EDP_HPD1_HPD1=$EDP_HPD1"

# if DP connect && EDP not connect, close backlight
if [ $DP0 = "0x79" ] && [ $DP1 = "0xdf" ] && [ $EDP0 = "0x48" ] && [ $EDP1 = "0x48" ]
then
	sudo su linaro -c "DISPLAY=:0.0 xrandr --output DP-1 --brightness 0"
	
	echo "control DP backlight successfully!"

fi