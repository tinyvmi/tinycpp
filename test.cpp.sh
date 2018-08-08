#!/bin/bash


tinyDir=$(dirname $0)

tinyVM="TinyCPP"
tinyID="0"

buildroot=mini-os-x86_64-tinycpp
dirname=tinycpp
makeTarget=tinycpp-stubdom

waitTime="1"

function Usage(){
  echo "--------------------------------------"
  echo "Usage: $0 [option [GNU make option]]"
  echo "Available options:"
  echo "'': if no option, it will just run TinyVMI without re-build."
  echo "'$0 make, m': just build TinyVMI, same as make -C stubdom/ tinyvmi-stubdom."
  echo "'$0 makerun, mr': build TinyVMI and run it."
  echo "'$0 build, b': make clean and rebuild TinyVMI."
  echo "'$0 buildrun, br': make clean and rebuild TinyVMI."
  echo "With last three options, you can also pass additional options to GNU make as following:"
  echo "'$0 make -j4'"
  echo "'$0 makerun -j4'"
  echo "'$0 build -j4'"
  echo "--------------------------------------"
  echo ""
}

git log | head


# create TinyVMI VM and run it.
function createTinyStub(){

  cd $buildroot
  xl create -c ../$dirname/domain_config 
  cd -

}


# go to dir of xen-src/stubdom/
cd $tinyDir
cd ..

options=""
if [ ! -z $2 ]; then
options="$2"
fi

opRun="run"
opMake="make"
opMakeRun="makerun"
opBuild="build"
opBuildRun="buildrun"
mode=$1

if [ -z "$mode" -o "$mode" == "$opRun" -o "$mode" == "r" ];then

  createTinyStub

elif [ "$mode" == "$opMake" -o "$mode" == "m" -o "$mode" == "$opMakeRun" -o "$mode" == "mr" ];then
 
  make $makeTarget $options
  res=$?
  if [ $res -ne 0 ]; then
    echo "error run make, return $res"
    exit $res
  fi

  if [ "$mode" == "$opMakeRun" -o "$mode" == "mr" ];then
    createTinyStub
  fi

elif [ "$mode" == "$opBuild" -o "$mode" == "b" -o "$mode" == "$opBuildRun" -o "$mode" == "br" ];then

  make clean -C ../extras/mini-os $options
  make clean -C $dirname $options

  make -C ../extras/mini-os $options
  res=$?
  if [ $res -ne 0 ]; then
    echo "error run make, return $res"
    exit $res
  fi

  make $makeTarget $options
  res=$?
  if [ $res -ne 0 ]; then
    echo "error run make, return $res"
    exit $res
  fi

  if [ "$mode" == "$opBuildRun" -o "$mode" == "br" ];then
    createTinyStub
  fi

else

  Usage
  
fi
