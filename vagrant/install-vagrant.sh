echo "install kvm"
sudo apt-get install qemu-kvm libvirt-bin virtinst libvirt-daemon-system libvirt-dev libvirt-clients bridge-utils

echo "install vagrant check https://www.vagrantup.com/downloads.html for current version"
curl -O https://releases.hashicorp.com/vagrant/2.2.9/vagrant_2.2.9_x86_64.deb
sudo apt install ./vagrant_2.2.9_x86_64.deb
vagrant --version

echo "install vagrant-libvirt dependencies"
sudo apt install qemu libvirt-daemon-system libvirt-clients libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev ruby-libvirt ebtables dnsmasq-base

#gem install nokogiri
#vagrant plugin install pkg-config

vagrant plugin install vagrant-libvirt
vagrant plugin list

export VAGRANT_DEFAULT_PROVIDER=libvirt
