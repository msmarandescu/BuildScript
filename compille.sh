#!/bin/bash

#rm -r out/ 2> /dev/null
rm -rf out/ | true
mkdir -p out/obj

echo "Compilation started:"
exitCode=$?
for f in $(find -type f -name "*.cpp")
do 
    $(g++ -Wall -g -c $f -o "out/obj/$(basename -- ${f%.*}.o)")
    exitCode=$?
    echo "  $f"
    if [ $exitCode -gt 0 ]
    then 
        break
    fi
done

if [ $exitCode -gt 0 ]
then 
    echo "Compilation failed! exit code:$exitCode"
else
    echo "Compilation successful!"
    echo

    echo "Linking started:"
    obj=""
    for o in $(ls "out/obj")
    do
        obj="$obj out/obj/$o"
        echo "  Linking file: "$o
    done
    $(g++ -o out/main.exe $obj)
    echo "Linking end!"
    echo "Project build successful!"

    echo
    echo "==================Program output:=================="
    out/main.exe
    echo "====================Program end===================="
fi
