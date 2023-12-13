#!/bin/bash

#rm -r out/ 2> /dev/null
rm -rf out/ | true
mkdir -p out/obj

echo "Compilation started:"
for f in $(find -type f -name "*.cpp")
do 
    $(g++ -Wall -g -c $f -o "out/obj/$(basename -- ${f%.*}.o)")
    echo $f
done
echo "Compilation successful!"
echo

echo "Linking started:"
obj=""
for o in $(ls "out/obj")
do
    obj="$obj out/obj/$o"
    echo "Linking file: "$o
done
echo "Linking end!"

$(g++ -o out/main.exe $obj)
echo
echo "Project build successful!"

echo
echo Program output:
out/main.exe
echo
