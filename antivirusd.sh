#!/bin/bash

if [ $# -ne 3 ]
then
  echo
  echo "$0 needs 3 arguments"
  echo "  Eg."
  echo "          $0 dir malicious_dir 5"
  exit 1
fi

dir=$1
malicious_dir=$2
interval=$3

mkdir -p "$malicious_dir"

extensions="exe|bat|vbs|scr|ps1"
keywords="virus|trojan|malware|worm|ransomware"

while true
do
  ls -l "$dir" > directory-info.new

  if [ ! -f directory-info.last ] || ! diff directory-info.last directory-info.new > /dev/null
  then
    for file in $dir/*
    do
      if [ -f "$file" ]
      then
        name=`basename "$file"`
        if echo "$name" | grep -qiE "\.($extensions)$" || grep -qiaE "$keywords" "$file"
        then
          echo "$name is malicious and it is DELETED"
          cp "$file" "$malicious_dir/$name"
          rm "$file"
        fi
      fi
    done
    cp directory-info.new directory-info.last
  fi

  sleep $interval
done
