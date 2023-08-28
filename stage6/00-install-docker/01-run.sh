#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/var/firstboot
docker pull ghcr.io/barneyman/gpsd-chrony-ntp
docker save ghcr.io/barneyman/gpsd-chrony-ntp | gzip > ${ROOTFS_DIR}/var/firstboot/1.tar.gz

# rpihaddev 3B - armv7l
# vpnhack 4 - aarch64
# rpi-pi-gen 400 - aarch64
# burner - aarch64


cp files/docker-compose.yml ${ROOTFS_DIR}/var/firstboot/
cp files/docker-compose-app.service ${ROOTFS_DIR}/etc/systemd/system/
cp files/firstboot.sh ${ROOTFS_DIR}/var/firstboot/

on_chroot << EOF
    # get the convenience script
    curl -fsSL https://get.docker.com -o get-docker.sh

    # and run it
    sh ./get-docker.sh

    # clean up
    rm ./get-docker.sh
    
    # add user
    usermod -aG docker ${FIRST_USER_NAME}    

    # start service
    systemctl enable docker-compose-app

EOF