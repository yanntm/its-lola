# its-lola

Crossover Petri net verifier using [its-tools](http://ddd.lip6.fr) newly introduced [structural reductions](https://hal.archives-ouvertes.fr/hal-02608600) in front of [Lola model-checker](http://service-technology.org/lola/).

This repository hosts artifacts that allowed to build the "its-lola" submission to the [Model-Checking Contest 2020 edition](https://mcc.lip6.fr/). This tool can handle the Reachability, Deadlock, Upper bounds, CTL and LTL examinations of the contest. 

Lola artifacts are taken from the 2019 submission to the Model-checking contest, as extracted from the submission of Karsten Wolf and Torsten Liebke.

ITS-Tools artifacts and scripts assembling the workflow were built by Yann Thierry-Mieg.

# Model Checking Contest Awards

This tool  won the following awards at the [Model-Checking Contest 2020 edition](https://mcc.lip6.fr/) which it was built to compete in :

 * LTL gold : ![Gold LTL](http://mcc.lip6.fr/certificates/2020/gold-LTL-2020.png)
 * UpperBounds gold : ![Gold UpperBounds](https://mcc.lip6.fr/certificates/2020/gold-UpperBounds-2020.png)
 * Reachability silver : ![Silver UpperBounds](https://mcc.lip6.fr/certificates/2020/silver-Reachability-2020.png)
 * CTL silver : ![Silver CTL](https://mcc.lip6.fr/certificates/2020/silver-CTL-2020.png)

It also got the first place (gold ?) in the [Deadlock Detection](https://mcc.lip6.fr/index.php?CONTENT=results/ReachabilityDeadlock.html&TITLE=Results%20for%20ReachabilityDeadlock) category, though in 2020 this category was merged into "GlobalProperties" (for the first time) so there is no related medal.
 
# Usage

As this tool conforms to the Model-Checking contest rules, please see the [MCC instructions]https://mcc.lip6.fr/pdf/MCC2020-SubmissionManual.pdf to see how these `BenchKit_head.sh` scripts are meant to be invoked, and what is expected outputs from the tool in terms of verdict reporting.

Basically you need : a `model.pnml` Petri net and an `Examination.xml` property file in the current working directory.

Then define the environment variables `BK EXAMINATION` (to one of `ReachabilityDeadlock,UpperBounds,ReachabilityCardinality,ReachabilityFireability,LTLFireability,LTLCardinality,CTLFireability,CTLCardinality`) and `BK TIME CONFINEMENT` (in seconds).

Finally invoke `BenchKit_head.sh` script.

More details can be inspected by [downloading the virtual machine](https://mcc.lip6.fr/2020/results.php) corresponding to this submission, only the major scripts and elements that are edited with respect to their ITS-tools or Lola sources are maintained in this repo. In other words we expect both its-tools and Lola to be present and functional already.

# Files in the repo

* `Benchkit_head.sh` normal entry point of the mcc : calls `its` then if there is a resulting file, calls `lola` versions of the script. 
* `Benchkit_head.its.sh` Invoke its-tools, passing `-rebuildPNML` flag, and no flags corresponding to actual model-checking solutions (`-its,-ltsmin,-smt` all disabled). If there remain properties to solve this builds a pair of files with `.sr.` added to their name.
* `Benchkit_head.lola.sh` outside of the name, this is basically taken directly from lola distribution
* `Makefile` : this is a core file of lola in the MCC contestant mode, that we edited slightly.
* `install_XXX.sh` : To install the tool dependencies, run the `install` shell scripts, but this step is not yet fully automated for lola component.

This software is freely available under terms of GPL.
