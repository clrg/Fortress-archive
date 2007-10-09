#!/bin/bash
#version 0.1
#Jule Slootbeek jslootbeek@gmail.com

if [ ! $1 ]
then
    echo "Usage: $0 [animation]"
    exit
fi

animation=$1;

#make sure animation exists
if [ ! -d $animation ] 
then
    echo "$animation does not exist"
    exit
fi

cd $animation

#directions: east, north, northeast, south and southeast

#create west, southwest and northwest
for frame in $(ls *fe_*);
do
    src=$frame
    tgt=$(echo $frame | sed -e "s/fe_/fw_/")
    convert ${src} -flop ${tgt}
done

for frame in $(ls *fne_*);
do
    src=$frame
    tgt=$(echo $frame | sed -e "s/fne_/fnw_/")
    convert ${src} -flop ${tgt}
done

for frame in $(ls *fse_*);
do
    src=$frame
    tgt=$(echo $frame | sed -e "s/fse_/fsw_/")
    convert ${src} -flop ${tgt}
done

#generate lines
for direction in e w n s ne se nw sw;
do
    cmd="convert "
    for file in $(ls ${animation}_f${direction}_[0-9]*.png);
    do
        cmd="${cmd} $file "
    done
    cmd="${cmd} +append ${animation}_f${direction}_sequence.png"
    $(${cmd})
done

#generate complete sequence
cmd="convert "
for sequence in $(ls *${animation}_f*_sequence*);
do
    cmd="${cmd} $sequence "
done
cmd="${cmd} -append ${animation}_sequence.png"

$(${cmd})
