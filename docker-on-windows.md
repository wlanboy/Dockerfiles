# Docker on Windows

Docker ohne Docker Desktop auf Windows betreiben — via WSL2 und Debian.

## Install WSL2

Moderner Einzeiler — installiert WSL2 mit Ubuntu als Standard-Distribution. PowerShell als Administrator ausführen.

```powershell
wsl --install
```

Für Debian statt Ubuntu:

```powershell
wsl --install -d Debian
```

Nach der Installation Windows neu starten und WSL-Benutzer anlegen.

## Get into Debian

In die WSL2-Shell wechseln.

```
wsl
```

## Fix iptables (Debian/Ubuntu)

iptables auf legacy umstellen — nötig damit Docker-Netzwerke in WSL2 funktionieren.

```bash
sudo update-alternatives --config iptables
# Option 1 (iptables-legacy) auswählen
```

## Install Docker

Docker CE aus dem offiziellen Repository installieren.

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Add user to Docker group

Damit Docker ohne `sudo` verwendet werden kann.

```bash
sudo usermod -aG docker $USER
```

## Configure default iptables and group id

GID der Docker-Gruppe auf einen festen Wert setzen (verhindert Konflikte bei mehreren WSL-Distros).

```bash
getent group | cut -d: -f3 | grep -E '^[0-9]{4}' | sort -g
sudo sed -i -e 's/^\(docker:x\):[^:]\+/\1:30000/' /etc/group
```

## Exit and restart WSL

WSL vollständig neu starten damit Gruppenänderungen wirksam werden.

```bash
exit
wsl --shutdown
wsl
```

## Start Docker daemon

Docker-Daemon im Hintergrund starten — in `.bashrc` eintragen für automatischen Start.

```bash
nohup sudo -b dockerd < /dev/null > /home/samuel/dockerd.log 2>&1
```

## Or use systemd (recommended)

Systemd in WSL2 aktivieren — dann startet Docker automatisch, kein manueller nohup-Befehl nötig.

```bash
cat <<EOF | sudo tee /etc/wsl.conf
[boot]
systemd=true
EOF
```

Danach WSL neu starten: `wsl --shutdown`

## Test installation

Prüfen ob Docker korrekt läuft.

```bash
docker run hello-world
```
