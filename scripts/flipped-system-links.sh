#!/bin/sh

# These links ensure that initramfs-tools-ubuntu-touch can mount partitions.
# Since we don't actually have an Android container to separate from the
# normal system, it's fine to just mount the partitions in root.
# The link from /root to / is due to the way the initramfs does its mounts --
# it mounts the rootfs into /root then switches into it. So /root/android ->
# /root, and then once the system is booted /root -> /.
ln -sf /root/ /android
rm -r /root
ln -sf / /root
