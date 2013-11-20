#!/bin/bash
# fargen-note.sh

notes_dir="$HOME/Dropbox/Notes"
month_dir=$notes_dir/`date +%Y/%m`
day_file=$month_dir/`date +%d`.md

# echo "** Running fargen note manager..."

if [ -z "$1" ]
then
    echo "** Opening today's note..."
    vi + $day_file
elif [ "$1" = "last" ]
then
    # echo "** Retrieving last note..."
    find $notes_dir -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" "
elif [ "$1" = "j" ]
then
    # journal entry
    vi $day_file
elif [ "$1" = "add" ]
then
    # echo "** Creating note..."
    # Create directory corresponding to current date
    mkdir -p $month_dir
    
    # Open document in editor
    vim + $day_file -c "$ r ! echo -e '\n\#\# '`date +\%R`'\n\n'"

else
    echo "** What do you want to do?"
fi

echo "** Hurray!"

exit 0
