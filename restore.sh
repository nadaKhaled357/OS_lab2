#!/bin/bash

if [ $# -ne 2 ]
then
  echo "Usage: $0 dir malicious_dir"
  exit 1
fi

dir=$1
malicious_dir=$2

while true
do
  count=$(ls "$malicious_dir" | wc -l)
  if [ $count -eq 0 ]
  then
    echo "No malicious files to review."
    exit 0
  fi

  ls "$malicious_dir" | cat -n
  echo "Pick a file number (or q to quit):"
  read choice || exit 0

  if [ "$choice" = "q" ]
  then
    exit 0
  fi

  if ! echo "$choice" | grep -qE '^[0-9]+$' || [ "$choice" -lt 1 ] || [ "$choice" -gt $count ]
  then
    echo "Invalid choice."
    continue
  fi

  file=$(ls "$malicious_dir" | head -n $choice | tail -n 1)
  echo "1) Restore this file back to $dir"
  echo "2) Permanently delete this file"
  echo "3) Leave this file as it is"
  read option || exit 0

  if [ "$option" = "1" ]
  then
    mv "$malicious_dir/$file" "$dir/$file"
    echo "Restored $file to $dir."
  elif [ "$option" = "2" ]
  then
    rm "$malicious_dir/$file"
    echo "$file permanently deleted."
  fi
done
