#!/bin/sh

MinValue=1
MaxValue=$(brightnessctl max)

current_value=$(brightnessctl get)

if [ $current_value = $MinValue ]; then
  brightnessctl set $MaxValue
else
  brightnessctl set $MinValue
fi
