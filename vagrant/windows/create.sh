#!/bin/sh
virt-install --os-type=windows --os-variant=win10 --name windows10 --ram=4096 --vcpus=4 --cpu host --disk path=/windows/windows10,size=60,bus=virtio,format=qcow2 --graphics=vnc,port=5910,listen=0.0.0.0 --network=default,model=virtio --network network=host-bridge,model=virtio --boot hd

virsh domiflist windows10ping 
virsh domifaddr windows10
