#!/bin/bash

prefix=""
postfix=".pdf"
targetDir="../str"
paddingLength=2

for file in ${prefix}[1-9]*${postfix}; do
  # strip the prefix off the file name
  postfile=${file#$prefix}
  # strip the postfix off the file name
  number=${postfile%$postfix}
  # subtract 1 from the resulting number
  i=$((number-1))
  # copy to a new name with padded zeros in a new folder
  cp ${file} "$targetDir"/$(printf $prefix%0${paddingLength}d$postfix $i)
done
