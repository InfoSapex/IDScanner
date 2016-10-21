#!/usr/bin/env bash

source $(dirname $0)/conf.sh

rm -rf $OUTPUT_FOLDER/
mkdir $OUTPUT_FOLDER
cp $TIFF_FOLDER/* $OUTPUT_FOLDER/
cp $BOX_FOLDER/* $OUTPUT_FOLDER/

function wrap {
    for i in `seq 0 $1`; do
        echo "$2$i$3"
    done
}

N=$(($1-1))


for i in `seq 0 $N`; do
    tesseract $OUTPUT_FOLDER/$2.ocrb.exp$i.tiff $OUTPUT_FOLDER/$2.ocrb.exp$i nobatch box.train
done

unicharset_extractor `wrap $N "$OUTPUT_FOLDER/$2.ocrb.exp" ".box"`

mv unicharset $OUTPUT_FOLDER/unicharset

echo "ocrb 0 0 1 0 0" > $OUTPUT_FOLDER/font_properties
mftraining -F $OUTPUT_FOLDER/font_properties -U $OUTPUT_FOLDER/unicharset -O $OUTPUT_FOLDER/$2.unicharset `wrap $N "$OUTPUT_FOLDER/$2.ocrb.exp" ".tr"`
cntraining `wrap $N "$OUTPUT_FOLDER/$2.ocrb.exp" ".tr"`

mv inttemp $OUTPUT_FOLDER/$2.inttemp
mv normproto $OUTPUT_FOLDER/$2.normproto
mv pffmtable $OUTPUT_FOLDER/$2.pffmtable
mv shapetable $OUTPUT_FOLDER/$2.shapetable

combine_tessdata $OUTPUT_FOLDER/$2.