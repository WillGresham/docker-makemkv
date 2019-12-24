#!/bin/bash

printf "Source Type: %s\n" $SOURCE_TYPE
FILEPATH='/tmp/makemkv.out'
TCOUNT=TCOUNT

printf "Scanning media for track information\n"
makemkvcon -r info $SOURCE_TYPE:/iso_in > /tmp/makemkv.out

TITLE_COUNT=$(cat $FILEPATH | grep $TCOUNT | sed -e 's/TCOUNT://')
printf "Title Count: %s\n\n" $TITLE_COUNT

COUNTER=0
while [[ $COUNTER -lt $TITLE_COUNT ]]; do
        TITLE=$(cat $FILEPATH | grep TINFO:$COUNTER,2, | sed -E 's/(TINFO:([0-9,]+)|")//ig')
        DURATION=$(cat $FILEPATH | grep TINFO:$COUNTER,9, | sed -E 's/(TINFO:([0-9,]+)|")//ig')
        SIZE=$(cat $FILEPATH | grep TINFO:$COUNTER,10, | sed -E 's/(TINFO:([0-9,]+)|")//ig')
        printf "Found title %d: %s\nDuration: %s\nFile Size: %s\n" $COUNTER "$TITLE" "$DURATION" "$SIZE"
        let COUNTER+=1
done

printf "Enter title selection: "
read SELECTION
printf "Chosen title: %s\n" $SELECTION

if [[ $SELECTION < $COUNTER ]]
then
        printf "Processing title %d\n" $SELECTION
	makemkvcon mkv --noscan $SOURCE_TYPE:/iso_in $SELECTION /iso_out
else
        printf "Invalid selection %d\n" $SELECTION
fi
exit 0
