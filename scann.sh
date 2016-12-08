#!/bin/bash

function doScan {
  sudo scanimage > "$(pwd)"/$1.ppm
  mogrify -format png $1.ppm 
  mkdir -p ppms
  mkdir -p pngs
  mv $1.ppm ppms
  mv $1.png pngs
  if [[ $2 == '-p' ]]; then
    okular pngs/$1.png
  fi
}

if [[ $# -lt 1 ]]; then
  echo "Usage: scann.sh <nazwa_pliku>"
  echo "Usage: scann.sh -a 	# przy skanowaniu więcej niż jeden raz. Pliki nazywa 1, 2...n"
  echo "Usage: scann.sh -a -p 	# przy skanowaniu więcej niż jeden raz. Pliki nazywa 1, 2...n. Po każdym skanowaniu wyświetla zeskanowany obraz."
  echo "Usage: scann.sh <nazwa_pliku> -p 	# Po skanowaniu wyświetla zeskanowany obraz."
elif [ $1 == '-a' ]; then
  count=1;
  ans=''
  while [ -z $ans ]; do
    doScan $count $2
    count=$[count + 1]
    echo "Continue to scan $count pic [Y/n]: "
    read ans
    if [[ "$ans" == y ]] || [[ "$ans" == Y ]]; then
       ans=""
    fi
  done
elif [ $2 == '-p' ]; then
  doScan $1 $2
else
  doScan $1
fi

