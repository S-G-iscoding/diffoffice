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
#TODO: Error messages if one of the files is not found.
#
#Changelog:
#  20200421: Add depenency management
#  20200421: Bugfix. Now it can deal with space in filenames, too.
#  20200421: add Help messages
#  20200715: Use mktemp -d for temp file creation.

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
