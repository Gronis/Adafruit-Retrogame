#!/bin/sh
echo '#!/bin/bash

# File:   /storage/.config/autostart.sh
#         chmod 777 /storage/.config/autostart.sh

#this is the GPIO pin connected to the lead on switch labeled OUT
GPIOpin1=14

#this is the GPIO pin connected to the lead on switch labeled IN
GPIOpin2=15

echo "$GPIOpin1" > /sys/class/gpio/export
echo "in" > /sys/class/gpio/gpio$GPIOpin1/direction
echo "$GPIOpin2" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$GPIOpin2/direction
echo "1" > /sys/class/gpio/gpio$GPIOpin2/value
power=1
while [ $power != 0 ]; do
	sleep 1
	power=$(cat /sys/class/gpio/gpio$GPIOpin1/value)
fi
sleep 1
poweroff
done' > /storage/.config/switch.sh
echo '#!/bin/bash
(
/storage/.config/switch.sh
)&' > /storage/.config/autostart.sh
chmod 777 /storage/.config/autostart.sh
chmod 777 /storage/.config/switch.sh
