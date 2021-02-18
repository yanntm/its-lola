BINDIR := $(shell echo $(BIN_DIR))

# catch the environment variable that determines what to do
# e.g. BK_EXAMINATION="ReachabilityDeadlock"
BK_EXAMINATION := $(shell echo $(BK_EXAMINATION))
# some variable from the given script
# e.g. BK_INPUT="FMS-PT-005"
CRT_DIR := $(shell echo $(BK_INPUT))

# we do not compete in State Space
DONOTCOMPETE = StateSpace

###############################################################################

verify:
	@echo "vrfy: Checking $(BK_EXAMINATION) @ $(CRT_DIR) @ $(remainingTime) seconds"

# Get the safe property and set it as option for LoLA
ifeq ($(shell grep SAFE GenericPropertiesVerdict.xml | cut -d \" -f 6),true)
	$(eval SAFE_OPTION := --safe)
else
	$(eval SAFE_OPTION := ) 
endif

# Check if there is a file 'large_marking' and skip this instance
ifneq ("$(wildcard large_marking)","")
	@-echo "can't compute: too many tokens on at least one place"

# Check if it is not a category we don't attend
else ifneq "$(findstring $(BK_EXAMINATION),$(DONOTCOMPETE))" ""

# CTL: (...
else ifeq ($(BK_EXAMINATION),CTLCardinality)
	@-for xml in $(wildcard *$(BK_EXAMINATION).xml); do \
	    touch $${xml%.xml}.result ; \
		$(BINDIR)/lola --pnmlnet model.pnml \
		--xmlformula --formula=$$xml --mcc \
	 	--donotcomputecapacities --encoder=simplecompressed $(SAFE_OPTION) \
		--check=modelchecking --stubborn=tarjan \
		--stateequation=par --quickchecks \
		--timelimit=$(remainingTime) --localtimelimit=0 \
		--preference=force_ctl \
		--json=$${xml%.xml}.json --jsoninclude=formula,formulastat,net \
		2> $${xml%.xml}.result ; \
	done
else ifeq ($(BK_EXAMINATION),CTLFireability)
	@-for xml in $(wildcard *$(BK_EXAMINATION).xml); do \
	    touch $${xml%.xml}.result ; \
		$(BINDIR)/lola --pnmlnet model.pnml \
		--xmlformula --formula=$$xml --mcc \
	 	--donotcomputecapacities --encoder=simplecompressed $(SAFE_OPTION) \
		--check=modelchecking --stubborn=tarjan \
		--stateequation=par --quickchecks \
		--timelimit=$(remainingTime) --localtimelimit=0 \
		--preference=force_ctl \
		--json=$${xml%.xml}.json --jsoninclude=formula,formulastat,net \
		2> $${xml%.xml}.result ; \
	done
# CTL: ...)
# ReachabilityDeadlock (...
else ifeq ($(BK_EXAMINATION),ReachabilityDeadlock)
	@-for xml in $(wildcard *$(BK_EXAMINATION).xml); do \
	    touch $${xml%.xml}.result ; \
		$(BINDIR)/lola --pnmlnet model.pnml \
		--xmlformula --formula=$$xml --mcc \
	 	--donotcomputecapacities --encoder=simplecompressed $(SAFE_OPTION) \
		--check=modelchecking --stubborn=combined \
	 	--siphontrap=par --siphondepth=10 --findpath=par --retrylimit=0 --depthlimit=1000000 \
		--symmetry --symmtimelimit=300 --threads=2 --symmetrydepth=1073741824 \
		--timelimit=$(remainingTime) \
		--json=$${xml%.xml}.json --jsoninclude=formula,formulastat,net \
		2> $${xml%.xml}.result ; \
	done
# ReachabilityDeadlock ...)
# LTL: (...
else ifeq ($(BK_EXAMINATION),LTLCardinality)
	@-for xml in $(wildcard *$(BK_EXAMINATION).xml); do \
	    touch $${xml%.xml}.result ; \
		$(BINDIR)/lola --pnmlnet model.pnml \
		--xmlformula --formula=$$xml --mcc \
	 	--donotcomputecapacities --encoder=simplecompressed $(SAFE_OPTION) \
		--check=modelchecking --stubborn=deletion \
		--stateequation=par \
		--timelimit=$(remainingTime) --localtimelimit=0 \
		--preference=force_ltl \
		--json=$${xml%.xml}.json --jsoninclude=formula,formulastat,net \
		2> $${xml%.xml}.result ; \
	done
else ifeq ($(BK_EXAMINATION),LTLFireability)
	@-for xml in $(wildcard *$(BK_EXAMINATION).xml); do \
	    touch $${xml%.xml}.result ; \
		$(BINDIR)/lola --pnmlnet model.pnml \
		--xmlformula --formula=$$xml --mcc \
	 	--donotcomputecapacities --encoder=simplecompressed $(SAFE_OPTION) \
		--check=modelchecking --stubborn=deletion \
		--stateequation=par \
		--timelimit=$(remainingTime) --localtimelimit=0 \
		--preference=force_ltl \
		--json=$${xml%.xml}.json --jsoninclude=formula,formulastat,net \
		2> $${xml%.xml}.result ; \
	done
# LTL: ...)
# Reachability (...
else ifeq ($(BK_EXAMINATION),ReachabilityCardinality)
	@-for xml in $(wildcard *$(BK_EXAMINATION).xml); do \
	    touch $${xml%.xml}.result ; \
		$(BINDIR)/lola --pnmlnet model.pnml \
		--xmlformula --formula=$$xml --mcc \
	 	--donotcomputecapacities --encoder=simplecompressed $(SAFE_OPTION) \
		--check=modelchecking --stubborn=tarjan \
		--stateequation=par \
		--timelimit=$(remainingTime) --localtimelimit=0 \
		--json=$${xml%.xml}.json --jsoninclude=formula,formulastat,net \
		2> $${xml%.xml}.result ; \
	done
else ifeq ($(BK_EXAMINATION),ReachabilityFireability)
	@-for xml in $(wildcard *$(BK_EXAMINATION).xml); do \
	    touch $${xml%.xml}.result ; \
		$(BINDIR)/lola --pnmlnet model.pnml \
		--xmlformula --formula=$$xml --mcc \
	 	--donotcomputecapacities --encoder=simplecompressed $(SAFE_OPTION) \
		--check=modelchecking --stubborn=tarjan \
		--stateequation=par \
		--timelimit=$(remainingTime) --localtimelimit=0 \
		--json=$${xml%.xml}.json --jsoninclude=formula,formulastat,net \
		2> $${xml%.xml}.result ; \
	done
# Reachability ...)
# UpperBounds (...
else ifeq ($(BK_EXAMINATION),UpperBounds)
	@-for xml in $(wildcard *$(BK_EXAMINATION).xml); do \
	    touch $${xml%.xml}.result ; \
		$(BINDIR)/lola --pnmlnet model.pnml \
		--xmlformula --formula=$$xml --mcc \
	 	--donotcomputecapacities --encoder=simplecompressed $(SAFE_OPTION) \
		--check=modelchecking --stubborn=tarjan \
		--timelimit=$(remainingTime) --localtimelimit=0 \
		--json=$${xml%.xml}.json --jsoninclude=formula,formulastat,net \
		2> $${xml%.xml}.result ; \
	done
# UpperBounds ...)
endif
	@echo "vrfy: finished"

###############################################################################

result:
	@echo "rslt: Output for $(BK_EXAMINATION) @ $(CRT_DIR)"
ifneq "$(findstring $(BK_EXAMINATION),$(DONOTCOMPETE))" ""
	@echo "DO_NOT_COMPETE"
else ifeq ($(BK_EXAMINATION),ReachabilityDeadlock)
ifneq ("$(wildcard large_marking)","")
	@echo "FORMULA $(CRT_DIR)-$(BK_EXAMINATION) CANNOT_COMPUTE" ;
endif
else ifneq ("$(wildcard large_marking)","")
	@-for number in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15; do \
        echo "FORMULA $(CRT_DIR)-$(BK_EXAMINATION)-$$number CANNOT_COMPUTE" ; \
    done ;
endif

ifneq ("$(wildcard $(BK_EXAMINATION).json)","")
	@-cat *$(BK_EXAMINATION).json
endif

ifneq ("$(wildcard $(BK_EXAMINATION).result)","")
	@-cat *$(BK_EXAMINATION).result
endif
	@echo "rslt: finished"

###############################################################################

clean:
	rm -f *.result *.json *.sara *.buechi *.path
