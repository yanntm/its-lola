#!/bin/bash

export PATH=$PATH:$BK_BIN_PATH/usr/local/bin

# get beginning time
startPreparationTime=$(date +%s);
TIME_CONFINEMENT=$BK_TIME_CONFINEMENT

if [[ "$OSTYPE" == "darwin"* ]]; then
    cp $BK_MCC_PATH/Makefile .
    export BIN_DIR="/Users/dorschden/Documents/modellchecking/mcc/vm/bin"
else
    cp $BK_BIN_PATH/Makefile .
    export BIN_DIR="$BK_BIN_PATH/usr/local/bin"
fi

# threshold value to detect small time confinements (e.g. qualification phase)
THRESHOLD=120

if [ $TIME_CONFINEMENT -gt $THRESHOLD ]
then
    # Use TIME_CONFINEMENT - 60 seconds as offset: MCC
    echo "info: Time: $BK_TIME_CONFINEMENT - MCC"
    offset=$(($TIME_CONFINEMENT-30))
else
    # Use TIME_CONFINEMENT - 15 seconds as offset: MCC qualification phase
    echo "info: Time: $BK_TIME_CONFINEMENT - MCC qualification phase"
    offset=$(($TIME_CONFINEMENT-10))
fi

# get time after preparation
endPreparationTime=$(date +%s);
# calculate remaining time
remainingTime=$(($offset + $startPreparationTime - $endPreparationTime));
export remainingTime;

# Start LoLA
make verify
endTimeVrfy=$(date +%s);
timeToVrfy=$(($endTimeVrfy - $startPreparationTime));
timeLeft=$(($remainingTime - $timeToVrfy));
echo "info: timeLeft: $timeLeft"

# Print CANNOT_COMPUTE and print result and json outputs
make result