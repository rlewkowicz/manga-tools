#!/bin/bash
wd=`pwd`
rm -f $wd/failed_mangas.txt
rm -f $wd/.manga_err
IFS=$'\n'
for i in `find . | grep 001.*` ; do
    path_to_first_image="$i"
    parent_folder_path_to_first_image=$(echo "$path_to_first_image" | sed -e 's;\/[^/]*$;;') 
    parent_folder_to_first_image=$(echo "$parent_folder_path_to_first_image" | sed -e 's;.*\/;;')  
    PDF_name="$parent_folder_to_first_image"
    parent_path_to_vol_name=$(echo "$parent_folder_path_to_first_image" | sed -e 's;\/[^/]*$;;')
    parent_to_vol_name=$(echo "$parent_path_to_vol_name" | sed -e 's;.*\/;;')
    series_name="$parent_to_vol_name"
    echo $parent_path_to_vol_name >> $wd/tmpfile
done

for i in `cat $wd/tmpfile | sort | uniq`; do
    cd $wd/$i
    for x in `\ls | grep -iE "ch\\.[0-9]*\\.?([0-9]*)"`; do
        mv "$x" $(echo $x | grep -ioE "ch\\.[0-9]*\\.?([0-9]*)") 
    done
done

cd $wd
rm -f $wd/tmpfile