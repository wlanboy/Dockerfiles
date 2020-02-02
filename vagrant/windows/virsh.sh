#!/bin/sh
WINIMG=./Windows.iso
VIRTIMG=./virtio-win.iso
virt-install --os-type=windows --os-variant=win10 --name windows10 --ram=4096 --vcpus=2 --cpu host \
--disk path=/windows/windows10,size=60,bus=virtio,format=qcow2 \
--disk /windows/Windows.iso,device=cdrom,bus=ide --disk /windows/virtio-win.iso,device=cdrom,bus=ide  \
--network network=br0,model=virtio \
--graphics=vnc,port=5910,listen=0.0.0.0
