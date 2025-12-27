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

        #Avoid negative modulo by turning always to the right
        by=$(( 100 - (num % 100) ))
        #How many times we cross hundred by doing the whole wheel around turn (floored division)
        crossed_hundred=$(( num / 100 ))
        #Add one if we would have crossed the zero going backwards
        if [ $((current_state - (num % 100))) -le 0 ] && [ $current_state != 0 ]; then
            crossed_hundred=$(( crossed_hundred + 1))
        fi

        current_state=$(( (current_state + by) % 100 ))

        echo "$instruction -> $current_state . Crossed $crossed_hundred"

        reached_zero=$((reached_zero + crossed_hundred))

    else 
        current_state=$((current_state + num))
        crossed_hundred=$((current_state / 100))

        current_state=$((current_state % 100))
        reached_zero=$((reached_zero + crossed_hundred))
        echo "$instruction -> $current_state . Crossed $crossed_hundred"
    fi


done

echo "Reached zero: $reached_zero"