#!/bin/sh
# Installiert Windows 10 als KVM-VM über virt-install.
#
# Voraussetzungen:
#   - Windows 10 ISO unter /windows/Windows.iso
#   - VirtIO-Treiber ISO unter /windows/virtio-win.iso
#     (Download: https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/)
#   - KVM/QEMU und libvirt müssen installiert und aktiv sein
#   - Bridge-Netzwerk 'br0' muss auf dem Host konfiguriert sein
#
# Disk:    qcow2-Image (60 GB) unter /windows/windows10, VirtIO-Bus für maximale Performance
# Netzwerk: Bridge-Modus über 'br0' mit VirtIO-Treiber
# Grafik:  VNC auf Port 5910, erreichbar von allen Interfaces (0.0.0.0)

WINIMG=./Windows.iso
VIRTIMG=./virtio-win.iso

virt-install \
  --os-type=windows \
  --os-variant=win10 \
  --name windows10 \
  --ram=4096 \
  --vcpus=2 \
  --cpu host \
  --disk path=/windows/windows10,size=60,bus=virtio,format=qcow2 \
  --disk /windows/Windows.iso,device=cdrom,bus=ide \
  --disk /windows/virtio-win.iso,device=cdrom,bus=ide \
  --network network=br0,model=virtio \
  --graphics=vnc,port=5910,listen=0.0.0.0
