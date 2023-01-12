#!/bin/bash

if [ "$2" = "" ]
then
  echo "Two arguments must be provided: edited photos directory's path and raws directory's path"
  exit 1
fi

edited_dir=$1
raws_dir=$2
photo_number_to_keep=()
echo $edited_dir
echo $raws_dir
for photo in "$edited_dir"/*
do
  photo_array=(${photo//// })
  photo_name=${photo_array[-1]}
  photo_number="${photo_name:16:4}"
  photo_number_to_keep+=($photo_number)
done
for value in "${photo_number_to_keep[@]}"
do
     echo $value
done
read -p "These are the ${#photo_number_to_keep[@]} raws you are about to keep in ${raws_dir}. Are you sure to delete the others ? [yes/no]" yn

case $yn in 
	yes ) echo ok, we will proceed;;
	no ) echo exiting...;
		exit;;
	* ) echo invalid response;
		exit 1;;
esac

for raw in "$raws_dir"/*.RW2
do
  raw_array=(${raw//// })
  raw_name=${raw_array[-1]}
  raw_number="${raw_name:4:4}"
  if [[ ! " ${photo_number_to_keep[*]} " =~ " ${raw_number} " ]]
  then
    rm $raw
  fi
done

