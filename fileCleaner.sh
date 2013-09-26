#!/bin/bash          
IP_FILE=$1
echo Starting with $IP_FILE
echo rule 1 - missing data
FILE_EXTENSION="${IP_FILE##*.}"
echo $FILE_EXTENSION
COMPLETE_NAME="${IP_FILE%.*}"
echo $COMPLETE_NAME
OP_FILE="$COMPLETE_NAME.clean_1"
OP_FILE="./$OP_FILE.$FILE_EXTENSION"
echo $OP_FILE
grep -v MISSING $IP_FILE | cat $OP_FILE
echo Done with rule 1 on $IP_FILE
echo Done with $IP_FILE