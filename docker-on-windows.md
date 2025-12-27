# Docker on Windows
All powershell commmands to install wsl and a linux container to run docker containers in Windows.


## Install WSL2 and prequisits
Powershell with administator rights
```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

## Restart Windows
```
Restart-Computer
```

## Set correct version and install Debian
```
wsl --set-default-version 2
wsl --install -d Debian
```

## Get into Debian
```
wsl
```

## Install Docker
```
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io 
```

## Configure default iptables, Docker group and group id
```
update-alternatives --config iptables # Select option 1
sudo usermod -aG docker $USER
getent group | cut -d: -f3 | grep -E '^[0-9]{4}' | sort -g
sudo sed -i -e 's/^\(docker:x\):[^:]\+/\1:30000/' /etc/group
```

## Exit Debian and shutdown WSL
```
exit
wsl --shutdown
```

## Start WSL2 Debian and start Docker daemon
```
wsl
nohup sudo -b dockerd < /dev/null > /home/samuel/dockerd.log 2>&1
```
> you can put that nohup command whereever you want (e.g. .bashrc)

## Or you use the new systemd feature of wsl
```
cat <<EOF | sudo tee /etc/wsl.conf
[boot]
systemd=true
EOF
```
