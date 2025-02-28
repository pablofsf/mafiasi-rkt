#!/bin/bash

NAME=base-stretch

. ../acbuildhelper.sh

acbuild set-name rkt.mafiasi.de/$NAME
debootstrap --variant=minbase stretch $T/.acbuild/currentaci/rootfs http://ftp.de.debian.org/debian/

acbuild run -- sh -es <<EOF
echo deb http://ftp.de.debian.org/debian stretch-updates main >> /etc/apt/sources.list
echo deb http://security.debian.org/ stretch/updates main >> /etc/apt/sources.list
apt update
apt upgrade -y
apt install -y vim ca-certificates
apt-get clean
mkdir /opt/config /opt/storage /opt/log
EOF

acbuild set-exec -- /bin/bash
acbuild write --overwrite $IMAGE_NAME
