#!/bin/sh

# Work around resolver failure in debos' fakemachine
mv /etc/resolv.conf /etc/resolv2.conf
echo "nameserver 1.1.1.1" > /etc/resolv.conf

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

echo "deb http://repo.ubports.com/ xenial_-_edge_-_mesa main" >> /etc/apt/sources.list.d/ubports.list
echo "deb http://repo.ubports.com/ xenial_-_edge_-_pine main" >> /etc/apt/sources.list.d/ubports.list
echo "deb http://repo.ubports.com/ xenial_-_edge_-_wayland main" >> /etc/apt/sources.list.d/ubports.list

echo "" >> /etc/apt/preferences.d/ubports.pref
echo "Package: *" >> /etc/apt/preferences.d/ubports.pref
echo "Pin: origin repo.ubports.com" >> /etc/apt/preferences.d/ubports.pref
echo "Pin: release o=UBports,a=xenial_-_edge_-_mesa" >> /etc/apt/preferences.d/ubports.pref
echo "Pin-Priority: 2001" >> /etc/apt/preferences.d/ubports.pref

echo "" >> /etc/apt/preferences.d/ubports.pref
echo "Package: *" >> /etc/apt/preferences.d/ubports.pref
echo "Pin: origin repo.ubports.com" >> /etc/apt/preferences.d/ubports.pref
echo "Pin: release o=UBports,a=xenial_-_edge_-_pine" >> /etc/apt/preferences.d/ubports.pref
echo "Pin-Priority: 2002" >> /etc/apt/preferences.d/ubports.pref

echo "" >> /etc/apt/preferences.d/ubports.pref
echo "Package: *" >> /etc/apt/preferences.d/ubports.pref
echo "Pin: origin repo.ubports.com" >> /etc/apt/preferences.d/ubports.pref
echo "Pin: release o=UBports,a=xenial_-_edge_-_wayland" >> /etc/apt/preferences.d/ubports.pref
echo "Pin-Priority: 2002" >> /etc/apt/preferences.d/ubports.pref

apt-get update
apt-get upgrade -y --allow-downgrades
apt-get autoremove -y

apt-get install ubuntu-touch-session-wayland libgbm1 libgl1-mesa-dri hfd-service libqt5feedback5-hfd -y

# Undo changes to work around debos fakemachine resolver
rm /etc/resolv.conf
mv /etc/resolv2.conf /etc/resolv.conf
