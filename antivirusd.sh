#!/bin/bash

if [ $# -ne 3 ]
then
  echo "Usage: $0 dir malicious_dir interval-secs"
  exit 1
fi

dir=$1
malicious_dir=$2
interval=$3

mkdir -p "$malicious_dir"

extensions="exe|bat|vbs|scr|ps1"
keywords="virus|trojan|malware|worm|ransomware"

scan()
{
  for file in "$dir"/*
  do
    if [ -f "$file" ]
    then
      name=$(basename "$file")
      bad=0
      if echo "$name" | grep -qiE "\.($extensions)$"
      then
        bad=1
      fi
      if grep -qiaE "$keywords" "$file"
      then
        bad=1
      fi
      if [ $bad -eq 1 ]
      then
        echo "$name is malicious and it is DELETED"
        cp "$file" "$malicious_dir/$name"
        rm "$file"
      fi
    fi
  done
}

if [ ! -f directory-info.last ]
then
  scan
  ls -l "$dir" > directory-info.last
fi

while true
do
  sleep $interval
  ls -l "$dir" > directory-info.new
  if ! cmp -s directory-info.last directory-info.new
  then
    scan
    cp directory-info.new directory-info.last
  fi
done
