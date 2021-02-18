#! /bin/bash


# grab, this is extracted from 2019 VM
if [ ! -f lola.tar.bz2 ] ; then
	wget https://github.com/yanntm/extractLola-2019/raw/master/lola.tar.bz2
fi

# decompress
if [ ! -d lola ] ; then
	tar xvjf lola.tar.bz2
fi

# todo : automate this part of the script
# basically : install dependencies, make and install sara, make and install lola
mkdir -p usr/
mkdir -p usr/local/
mkdir -p usr/local/bin/
mkdir -p usr/local/share/man/man1/


export INSTALL_DIR=$(pwd)/usr/local/

# build
cd lola/bin

# kimwitu dependency
cd kimwitu++-2.3.13/
./configure --prefix=$INSTALL_DIR
make && make install
cd ..
 
cd sara/
./configure --prefix=$INSTALL_DIR
make && make install
cd ..
 
cd lola/
# don't build doc
cp ../../../patches/Makefile.am .
# issues with new LTO enabled compilers
cp ../../../patches/generalized.c ./src/Formula/LTL/
autoreconf -vfi
./configure --prefix=$INSTALL_DIR
make && make install
cd ..


