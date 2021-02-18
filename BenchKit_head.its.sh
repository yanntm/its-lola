#!/bin/bash
#############################################################################
# This is an example for the MCC'2015
#############################################################################

#############################################################################
# In this script, you will affect values to your tool in order to let
# BenchKit launch it in an apropriate way.
#############################################################################

# BK_EXAMINATION: it is a string that identifies your "examination"

set -x
export BINDIR=$BK_BIN_PATH

export MODEL=$(pwd)

$BINDIR/runeclipse.sh $MODEL $BK_EXAMINATION -timeout $BK_TIME_CONFINEMENT -rebuildPNML
