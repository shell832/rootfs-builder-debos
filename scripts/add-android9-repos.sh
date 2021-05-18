#!/bin/sh

CHANNEL=${1:-devel}

# Temporary set up the nameserver
mv /etc/resolv.conf /etc/resolv2.conf
echo "nameserver 1.1.1.1" > /etc/resolv.conf

export DEBIAN_FRONTEND=noninteractive
export DEBCONF_NONINTERACTIVE_SEEN=true

echo "deb http://repo.ubports.com/ xenial_-_android9 main" >> /etc/apt/sources.list.d/ubports-android9.list
echo "deb http://repo.ubports.com/ xenial_-_android9_-_android10 main" >> /etc/apt/sources.list.d/ubports-android9.list
echo "deb http://repo.ubports.com/ xenial_-_hidltest main" >> /etc/apt/sources.list.d/ubports-xenial_-_hidltest.list

echo "Package: *" >> /etc/apt/preferences.d/ubports-android9.pref
echo "Pin: release o=UBports,a=xenial_-_android9" >> /etc/apt/preferences.d/ubports-android9.pref
echo "Pin-Priority: 2010" >> /etc/apt/preferences.d/ubports-android9.pref
echo "" >> /etc/apt/preferences.d/ubports-android9.pref

echo "Package: *" >> /etc/apt/preferences.d/ubports-android9.pref
echo "Pin: release o=UBports,a=xenial_-_android9_-_android10" >> /etc/apt/preferences.d/ubports-android9.pref
echo "Pin-Priority: 2011" >> /etc/apt/preferences.d/ubports-android9.pref

echo "Package: *" >> /etc/apt/preferences.d/ubports-xenial_-_hidltest.pref
echo "Pin: release o=UBports,a=xenial_-_hidltest" >> /etc/apt/preferences.d/ubports-xenial_-_hidltest.pref
echo "Pin-Priority: 2011" >> /etc/apt/preferences.d/ubports-xenial_-_hidltest.pref

if [ "$CHANNEL" == "edge" ]; then
    echo "deb http://repo.ubports.com/ xenial_-_edge_-_android9 main" >> /etc/apt/sources.list.d/ubports-android9.list

    echo "Package: *" >> /etc/apt/preferences.d/ubports-android9.pref
    echo "Pin: release o=UBports,a=xenial_-_edge_-_android9" >> /etc/apt/preferences.d/ubports-android9.pref
    echo "Pin-Priority: 2020" >> /etc/apt/preferences.d/ubports-android9.pref
fi

apt update
apt upgrade -y --allow-downgrades

apt install -y bluebinder ofono-ril-binder-plugin pulseaudio-modules-droid-28 pulseaudio-modules-droid-29
# sensorfw
apt remove -y qtubuntu-sensors
apt install -y libsensorfw-qt5-hybris libsensorfw-qt5-configs libsensorfw-qt5-plugins libqt5sensors5-sensorfw qtubuntu-position
# hfd-service
apt install -y hfd-service libqt5feedback5-hfd hfd-service-tools
# in-call audio
apt install -y pulseaudio-modules-droid-hidl-28 audiosystem-passthrough

# Restore symlink
rm /etc/resolv.conf
mv /etc/resolv2.conf /etc/resolv.conf
