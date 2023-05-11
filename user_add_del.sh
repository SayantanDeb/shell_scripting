#!/bin/bash

#This file creates users and respective password from a list of Names provided in a file ref: names.txt
#Thsi script needs the file name to be provided during execution

while getopts 'a:d:' OPTION; 
  do
  case "$OPTION" in
    a)
        file="$OPTARG"
	IFS=$'\n'  
	> useradd.txt
	for i in `cat $file`
	do
	NAME=`echo $i | cut -d ' ' -f1`
	SURNAME=`echo $i | cut -d ' ' -f2`
	USERNAME=`echo "$NAME.$SURNAME"`
	PASSWORD=`echo $RANDOM | md5sum | head -c 8; echo;`
	useradd -m $USERNAME 
	echo $PASSWORD | passwd --stdin $USERNAME
	echo -e "\nUser has been added for $i, USERNAME:  $USERNAME, PASSWORD: $PASSWORD\n"  
	echo -e "\n$i, $USERNAME, $PASSWORD\n"  >> useradd.txt
	done
     	 ;;
    d)
        file="$OPTARG"
	IFS=$'\n'
	for i in `cat $file`
	do
	NAME=`echo $i | cut -d ' ' -f1`
	SURNAME=`echo $i | cut -d ' ' -f2`
	USERNAME=`echo "$NAME.$SURNAME"`
	userdel -r $USERNAME
	echo -e "\nUser has been deleted for $i, USERNAME:  $USERNAME\n"
	done
       	;;
    ?)
   	echo "script usage: $(basename $0) [-a filename] [-d filename]" >&2
     	exit 1
     	 ;;
 	 esac
  done

if ((OPTIND == 1))
then
	echo "script usage: $(basename $0) [-a filename] [-d filename]" >&2
	exit 1
fi

shift "$(($OPTIND -1))"

