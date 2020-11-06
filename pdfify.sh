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
    echo $series_name/$PDF_name
    mkdir -p $wd/converted_mangas/$series_name
    cd "$parent_folder_path_to_first_image"
    if test -f "$wd/converted_mangas/$series_name/"$PDF_name".pdf"; then
        cd $wd
        continue
    fi
    for x in `\ls | grep -E "(gif|jpe?g|tiff?|png|webp|bmp)"`; do
        grep "alpha" < <(convert $x -verbose info: 2>/dev/null) > /dev/null
        if [[ $? == 0 ]]; then
            convert $x -background white -alpha remove -alpha off $x.tmp 2>/dev/null
            if [[ $? == 0 ]]; then
                mv $x.tmp $x
            fi
        fi
    done
    img2pdf $(\ls | grep -E "(gif|jpe?g|tiff?|png|webp|bmp)") --fit enlarge --imgsize 4 --output $wd/converted_mangas/$series_name/"$PDF_name".pdf &>$wd/.manga_err #it doesn't +zero code
    grep . $wd/.manga_err &> /dev/null
    if [[ $? == 0 ]]; then
        echo "$series_name/$PDF_name - error: see failed_mangas.txt, no matter the error, it's probably a bad download"
        err=`cat $wd/.manga_err | grep 'error:'`
        rm -f $wd/converted_mangas/$series_name/"$PDF_name".pdf
        rm -f $wd/.manga_err
        echo "$parent_folder_path_to_first_image - $err" >> $wd/failed_mangas.txt
    fi
    cd $wd
done