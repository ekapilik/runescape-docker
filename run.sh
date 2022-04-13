#!/bin/bash

# Debug option gives a bash shell inside the container, instead of going directly to RS
if [ "$1" == "--debug" ] ; then
  EXTRA_ARGS="-it"
  RS_COMMAND="/bin/bash" ;
else
  RS_COMMAND="runescape-launcher" ;
fi

RS_USER=$(logname)
RS_UID=$(id -u $RS_USER)

xhost + # allow connections to X server

docker run --privileged --rm \
    -e "DISPLAY=${DISPLAY}" \
    -e "__NV_PRIME_RENDOR_OFFLOAD=1" \
    -e "__GLX_VENDOR_LIBRARY_NAME=nvidia" \
    -e "NVIDIA_VISIBLE_DEVICES=all" \
    -e "NVIDIA_DRIVER_CAPABILITES=graphics,utility,compute" \
    -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -v "/etc/machine-id:/etc/machine-id" \
    -v "/run/user/${RS_UID}/pulse:/run/user/${RS_UID}/pulse" \
    -v ~/.pulse:"/home/${RS_USER}/.pulse" \
    -v "/root/Jagex:/root/Jagex" \
    ${EXTRA_ARGS} runescape ${RS_COMMAND}
