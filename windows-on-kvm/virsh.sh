#!/bin/sh
# Startet eine bereits installierte Windows 10 KVM-VM und zeigt Netzwerkinformationen.
#
# Voraussetzungen:
#   - VM 'windows10' muss mit create.sh erstellt worden sein
#   - KVM/QEMU und libvirt müssen installiert und aktiv sein
#
# Boot:    Startet direkt von der Festplatte (kein ISO-Boot)
# Netzwerk: Standard-Netzwerk (default) und Host-Bridge (host-bridge), beide mit VirtIO
# Grafik:  VNC auf Port 5910, erreichbar von allen Interfaces (0.0.0.0)
# RAM:     4096 MB, CPU: 4 vCPUs mit Host-CPU-Passthrough

virt-install \
  --os-type=windows \
  --os-variant=win10 \
  --name windows10 \
  --ram=4096 \
  --vcpus=4 \
  --cpu host \
  --disk path=/windows/windows10,size=60,bus=virtio,format=qcow2 \
  --graphics=vnc,port=5910,listen=0.0.0.0 \
  --network=default,model=virtio \
  --network network=host-bridge,model=virtio \
  --boot hd

# Netzwerkinterfaces der VM auflisten
virsh domiflist windows10

# IP-Adressen der VM anzeigen
virsh domifaddr windows10
