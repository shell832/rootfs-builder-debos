#!/bin/bash

set -e

# Copies all of the mounts from $1 into $2.
replicate_mounts () {
    SOURCE="${1}"
    DEST="${2}"
    for f in ${1}/*/; do
        NAME="$(basename ${f})"
        if [ -d ${f} ]; then
            DIR="${DEST}/${NAME}"
            echo "Moving ${f} to ${DIR}"
            mkdir "${DIR}"
            mount --bind "${SOURCE}/${NAME}" "${DIR}"
        fi
    done
}

rm -r mnt/lost+found/
mkdir mnt_outer/

replicate_mounts "mnt" "mnt_outer"

umount mnt/*
rmdir mnt/*
umount mnt

mke2fs mnt_outer/userdata/rootfs.img 3G
mkdir mnt || true
mount mnt_outer/userdata/rootfs.img mnt/

replicate_mounts "mnt_outer/" "mnt/"

umount mnt_outer/* || true
