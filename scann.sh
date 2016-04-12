#!/bin/bash

if [ $# -lt 1 ]; then
  echo "podaj nazwe pliku."
else
  sudo scanimage > "$(pwd)"/$1.ppm
  mogrify -format png $1.ppm 
fi
