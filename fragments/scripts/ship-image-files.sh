#!/bin/sh

set -e

# Copies all of the partitions specified by partlabel in a space-separated list
# as $1 to the directory specified by $2

PARTLABELS="$1"
OUT="$2"

mkdir -p "$OUT"

for ENTRY in $PARTLABELS; do

    # Split label:destination or use the default label.img
    case $ENTRY in
        (*:*) PARTLABEL="${ENTRY%:*}" OUTFILE="${ENTRY##*:}.img";;
        (*) PARTLABEL="$ENTRY" OUTFILE="$ENTRY.img"
    esac

    DEVICE=$(blkid --match-token PARTLABEL="$PARTLABEL" --output device)
    dd if="$DEVICE" of="$OUT/$OUTFILE" bs=4M
done
