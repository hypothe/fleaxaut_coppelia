#!/bin/bash

docker run --gpus all -dit -P --env NVIDIA_DRIVER_CAPABILITIES='graphics,compute,utility' \
 --env DISPLAY \
 --env QT_X11_NO_MITSHM=1 \
 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw \
 hypothe/flexaut:coppelia-prebuilt