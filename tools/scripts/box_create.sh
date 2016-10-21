#!/usr/bin/env bash

source $(dirname $0)/conf.sh

N=$(($1-1))

has_new=false

for i in `seq 0 $N`; do
    if [ ! -f $BOX_FOLDER/$2.ocrb.exp$i.box ]; then
        echo "Making new box: $2.ocrb.exp$i.box"
        has_new=true
        tesseract $TIFF_FOLDER/$2.ocrb.exp$i.tiff $BOX_FOLDER/$2.ocrb.exp$i batch.nochop makebox
    fi
done

if $has_new; then
    echo "New box files created, please edit these box files and then proceed with training."
else
    echo "Proceed with training"
fi