# Windows 10 mit KVM/QEMU

Dieses Verzeichnis enthält Shell-Skripte zur Installation und zum Betrieb einer Windows 10 VM unter KVM/QEMU mit libvirt. VirtIO-Treiber sorgen für maximale I/O-Performance bei Disk und Netzwerk.

## Dateien

| Datei | Beschreibung |
|---|---|
| `create.sh` | Installiert Windows 10 aus ISO inkl. VirtIO-Treibern (Erstinstallation) |
| `virsh.sh` | Startet eine bereits installierte Windows-VM und zeigt Netzwerkinformationen |

## Voraussetzungen

- KVM/QEMU und libvirt installiert und aktiv (`systemctl status libvirtd`)
- Benutzer ist Mitglied der Gruppe `libvirt` und `kvm`
- VirtIO-Treiber ISO vorhanden (für Windows benötigt, da VirtIO kein Inbox-Treiber ist)
- Bridge-Netzwerk `br0` auf dem Host konfiguriert (für `create.sh`)

```bash
# VirtIO-Treiber ISO herunterladen
wget https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso \
  -O /windows/virtio-win.iso
```

## Konfiguration

| Parameter | Wert |
|---|---|
| VM-Name | `windows10` |
| RAM | `4096 MB` |
| vCPUs | `2` (create) / `4` (virsh) |
| CPU-Modus | `host` (Passthrough) |
| Disk | `/windows/windows10`, 60 GB, qcow2, VirtIO-Bus |
| Netzwerk (create) | Bridge `br0`, VirtIO |
| Netzwerk (virsh) | `default` + `host-bridge`, VirtIO |
| Grafikausgabe | VNC, Port `5910`, alle Interfaces |

## Verwendung

### Erstinstallation

Windows 10 ISO und VirtIO-ISO müssen unter `/windows/` bereitliegen:

```bash
chmod +x create.sh
./create.sh
```

VNC-Client auf `<host-ip>:5910` verbinden und die Windows-Installation durchführen.  
Beim Disk-Setup den VirtIO-Treiber aus der zweiten CD-ROM laden, damit das Laufwerk erkannt wird.

### VM starten (nach Erstinstallation)

```bash
chmod +x virsh.sh
./virsh.sh
```

## Nützliche virsh-Befehle

```bash
# Laufende VMs anzeigen
virsh list

# VM stoppen
virsh shutdown windows10

# VM hart abschalten
virsh destroy windows10

# VM beim Host-Start automatisch starten
virsh autostart windows10

# VM-Snapshot erstellen
virsh snapshot-create-as windows10 snapshot1

# Konsolenverbindung (falls konfiguriert)
virsh console windows10
```

## Hinweise

- Der `--cpu host`-Parameter gibt der VM direkt Zugriff auf die Host-CPU-Features (besser für Performance, schlechter für Live-Migration).
- VNC ist ohne Authentifizierung konfiguriert – für Produktionsumgebungen TLS oder SSH-Tunnel verwenden.
- Das qcow2-Format ermöglicht Snapshots und Thin Provisioning; die Datei wächst nur so groß wie tatsächlich genutzt.
