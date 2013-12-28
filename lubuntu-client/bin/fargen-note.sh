#!/bin/bash
# fargen-note.sh

notes_dir="$HOME/Dropbox/Notes"
year_dir="$notes_dir/$(date +%Y)"
day_file="$year_dir/$(date +%F).md"

if [ -z "$1" -o "$1" = "j" -o "$1" = "journal" ]
then
    echo "** Opening today's note..."
    # Create directory corresponding to current date
    mkdir -p $year_dir
    vi + "$day_file"
elif [ "$1" = "d" -o "$1" = "dir" ]
then
    echo $year_dir
elif [ "$1" = "last" ]
then
    find $notes_dir -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" "
elif [ "$1" = "add" -o "$1" = "new" ]
then
    if [ -n "$2" ]
    then
        echo "** Creating note..."
        mkdir -p $year_dir
        vi + "$year_dir/$2"
    else
	echo "** Warning: No note name specified!"
	vi +"lcd $year_dir"
    fi
    # Open document in editor
    #vim + $day_file -c "$ r ! echo -e '\n\#\# '`date +\%R`'\n\n'"
elif [ "$1" = "help" ]
then
    cat <<EOM
	Options:
	j, journal	    Open markdown document for today's date in editor
	d, dir		    Output path to current year's note directory
	last		    Output path to last edited note
	add [title],	    Add note with given title to current year's note directory
	    new [title]	    
	help		    Display help
EOM
else
    echo "** What do you want to do?"
fi

exit 0
