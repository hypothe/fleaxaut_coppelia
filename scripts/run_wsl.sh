#!/bin/bash

DISPLAY=$(grep nameserver /etc/resolv.conf | awk '{print $2}'):0.0

docker run -dit --gpus all -P --env NVIDIA_DRIVER_CAPABILITIES='graphics,compute,utility' \
 --env DISPLAY=$DISPLAY \
 --env "PULSE_SERVER=${PULSE_SERVER}" -v /mnt/wslg/:/mnt/wslg/ \
 hypothe/flexaut:coppelia-prebuilt