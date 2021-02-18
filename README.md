# its-lola

Crossover Petri net verifier using [its-tools](http://ddd.lip6.fr) newly introduced [structural reductions](https://hal.archives-ouvertes.fr/hal-02608600) in front of [Lola model-checker](http://service-technology.org/lola/).

This repository hosts artifacts that allowed to build the "its-lola" submission to the [Model-Checking Contest 2020 edition](https://mcc.lip6.fr/). This tool can handle the Reachability, Deadlock, Upper bounds, CTL and LTL examinations of the contest. 

Lola artifacts are taken from the 2019 submission to the Model-checking contest, as extracted from the submission of Karsten Wolf and Torsten Liebke.

ITS-Tools artifacts and scripts assembling the workflow were built by Yann Thierry-Mieg.

# Model Checking Contest Awards

This tool  won the following awards at the [Model-Checking Contest 2020 edition](https://mcc.lip6.fr/) which it was built to compete in :

 * LTL gold : <img src="http://mcc.lip6.fr/certificates/2020/gold-LTL-2020.png" alt="Gold LTL" width="50px" height="50px">
 * UpperBounds gold : <img src="http://mcc.lip6.fr/certificates/2020/gold-UpperBounds-2020.png" alt="Gold UpperBounds" width="50px" height="50px">
 * Reachability silver : <img src="http://mcc.lip6.fr/certificates/2020/silver-Reachability-2020.png" alt="Silver Reachability" width="50px" height="50px">
 * CTL silver : <img src="http://mcc.lip6.fr/certificates/2020/silver-Reachability-2020.png" alt="Silver Reachability" width="50px" height="50px">

It also got the first place (gold ?) in the [Deadlock Detection](https://mcc.lip6.fr/index.php?CONTENT=results/ReachabilityDeadlock.html&TITLE=Results%20for%20ReachabilityDeadlock) category, though in 2020 this category was merged into "GlobalProperties" (for the first time) so there is no related medal.
 
# Usage

As this tool conforms to the Model-Checking contest rules, please see the [MCC instructions](https://mcc.lip6.fr/pdf/MCC2020-SubmissionManual.pdf) to see how these `BenchKit_head.sh` scripts are meant to be invoked, and what is expected outputs from the tool in terms of verdict reporting.

Basically you need : a `model.pnml` Petri net and an `Examination.xml` property file in the current working directory.

Then define the environment variables `BK EXAMINATION` (to one of `ReachabilityDeadlock,UpperBounds,ReachabilityCardinality,ReachabilityFireability,LTLFireability,LTLCardinality,CTLFireability,CTLCardinality`) and `BK TIME CONFINEMENT` (in seconds).

If you are not running in the default MCC path `/home/mcc/BenchKit`, also define `BK_BIN_PATH` to the installation folder where you ran `./install_all.sh`.

Finally invoke `BenchKit_head.sh` script.

More details could be inspected by [downloading the virtual machine](https://mcc.lip6.fr/2020/results.php) corresponding to this submission, only the major scripts and elements that are edited with respect to their ITS-tools or Lola sources are maintained in this repo. In other words we expect both its-tools and Lola to be present and functional already.

# Testing

This tool being compliant to MCC can be tested using our MCC testing framework https://github.com/yanntm/pnmcc-tests :

Set it up like this :
```
git clone https://github.com/yanntm/its-lola.git
cd its-lola
./install_all.sh
git clone https://github.com/yanntm/pnmcc-tests.git
cp -r pnmcc-tests/* .
./install_oracle.sh
```

Then for any test in `oracle/` you can run :
```
./run_test.pl oracle/Angiogenesis-PT-05-LTLF.out
``` 

To ensure the build is reproducible there is a Github Actions attached to this repository that runs this exact test, see https://github.com/yanntm/its-lola/actions for some logs of it running.

# Files in the repo

* `Benchkit_head.sh` normal entry point of the mcc : calls `its` then if there is a resulting file, calls `lola` versions of the script. 
* `Benchkit_head.its.sh` Invoke its-tools, passing `-rebuildPNML` flag, and no flags corresponding to actual model-checking solutions (`-its,-ltsmin,-smt` all disabled). If there remain properties to solve this builds a pair of files with `.sr.` added to their name.
* `Benchkit_head.lola.sh` outside of the name, this is basically taken directly from lola distribution
* `Makefile` : this is a core file of lola in the MCC contestant mode, that we edited slightly.
* `install_XXX.sh` : To install the tool and its dependencies, run the `install_all.sh` that calls all the other install shell scripts. You need a C compiler and might also need autotools. 

### Acknowledgements

Yann Thierry-Mieg, LIP6, Sorbonne Université, CNRS.
This software is freely available under the terms of GPL v3, see License file.
