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

bash /home/mcc/BenchKit/BenchKit_head.its.sh

if [ -f model.sr.pnml ] 
then
	rm -f large_marking
	cp model.pnml model.ori.pnml
	cp $BK_EXAMINATION.xml $BK_EXAMINATION.ori.xml
	cp model.sr.pnml model.pnml
	cp $BK_EXAMINATION.sr.xml $BK_EXAMINATION.xml
	bash /home/mcc/BenchKit/BenchKit_head.lola.sh
fi
