#!/bin/bash
#This little script implements a diff function for any file format that is supported by LibreOffice. 
#It takes two arguments: the first and the second file to compare.
#
#Dependencies:
#  LibreOffice
#  diffpdf
#
#License: MIT License
#
#Changelog:
#  20200421: Add depenency management
#  20200421: Bugfix. Now it can deal with space in filenames, too.
#  20200421: add Help messages
#  20200715: Use mktemp -d for temp file creation.
#  20200715: Add error message if file not found with error code 1.

#help
if [ $# -ne 2 ] ; then 
    if [ $# -ne 0 ] ; then 
        echo "Wrong number of arguments."
    fi
    echo "This script shows a diff of two different office documets (texts, spreadsheets, presentations etc.) that can be read by LibreOffice."
    echo "Usage:"
    echo "  $0 <first file to compare> <second file to compare> #showing a diff for two files."
    echo "  $0 #showing this help message."
    exit
fi

#dependency management
if ! command -v soffice >/dev/null 2>&1 ; then
    echo "command soffice not found. This script needs LibreOffice to be installed."
    exit
fi

if ! command -v diffpdf >/dev/null 2>&1 ; then
    echo "diffpdf not found. This script needs diffpdf to be installed."
    exit
fi

#check if files are missing
fail_because_of_missing_file=0

if ! [[ -f "$1" ]]; then
    echo "Error: The file $1 does not exist."
    fail_because_of_missing_file=1
fi
if ! [[ -f "$2" ]]; then
    echo "Error: The file $2 does not exist."
    fail_because_of_missing_file=1
fi

if [[ 0 -ne $fail_because_of_missing_file ]]; then
    exit 1
fi

#preparation
tmpfolder=$(mktemp -d)
mkdir $tmpfolder/1
mkdir $tmpfolder/2

#converting to pdf
soffice --headless --convert-to pdf "$1" --outdir "$tmpfolder/1"
soffice --headless --convert-to pdf "$2" --outdir "$tmpfolder/2" 

#compare
diffpdf $tmpfolder/1/*.pdf $tmpfolder/2/*.pdf

#cleanup
rm -r $tmpfolder
