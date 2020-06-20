# its-lola

Crossover Petri net verifier using [its-tools structural reductions](https://hal.archives-ouvertes.fr/hal-02608600) in front of [Lola model-checker](http://service-technology.org/lola/).

This repository hosts artifacts that allowed to build the "its-lola" submission to the [Model-Checking Contest 2020 edition](https://mcc.lip6.fr/).

Lola artifacts are taken from the 2019 submission to the Model-checking contest, as extracted from the submission of Karsten Wolf and Torsten Liebke.

ITS-Tools artifacts and scripts assembling the workflow were built by Yann Thierry-Mieg.

More details can be inspected by [downloading the virtual machine](https://mcc.lip6.fr/2020/results.php) corresponding to this submission, only the major scripts and elements that are edited with respect to their ITS-tools or Lola sources are maintained in this repo.

# Files in the repo

* `Benchkit_head.sh` normal entry point of the mcc : calls `its` then if there is a resulting file, calls `lola` versions of the script. 
* `Benchkit_head.its.sh` Invoke its-tools, passing `-rebuildPNML` flag, and no flags corresponding to actual model-checking solutions (`-its,-ltsmin,-smt` all disabled). If successful this builds a pair of files with `.sr.` added to their name.
* `Benchkit_head.lola.sh` outside of the name, this is basically taken directly from lola distribution
* `Makefile` : this is a core file of lola in the MCC contestant mode, that we edited slightly.
* `install_XXX.sh` : grab the actual binaries for the tools



This software is freely available under terms of GPL.
