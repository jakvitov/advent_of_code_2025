#!/bin/bash
#Expecting a name of file with input data at the input
if [ -z "$1" ] || [ -z "$2" ] ; then
    echo "Two arguments required"
    exit -1
fi

echo "Reading file input: $1"
echo "Using initial state of: $2"

if [ ! -f $1 ]; then
    echo "File $1 not found!"
    exit -1
fi


input_file=$(cat "$1")

reached_zero=0
current_state=$2

if [ $current_state -eq 0 ]; then
    current_state=1
fi


for instruction in $input_file 
do
    direction=${instruction:0:1}
    num=${instruction:1}
    
    if [ $direction == "L" ]; then
        current_state=$(( ((current_state - num) % 100 + 100) % 100 ))
    else 
        current_state=$(( ((current_state + num) % 100 + 100) % 100 ))
    fi

    if [ $current_state -eq 0 ]; then
        reached_zero=$((reached_zero + 1))
    fi

    echo "$instruction -> $current_state"

done

echo "Reached zero: $reached_zero"