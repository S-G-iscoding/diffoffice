# diffoffice
Comparing documents, presentations, spreadsheets and more.

## How it works
This small script works under Linux if LibreOffice and DiffPDF is installed.
It converts a lot of different file formats like documents, presentations, spreadsheets and more to temporary pdf files using LibreOffice as a converter. Then DiffPDF is invoked to show the difference between the two files.

## Installation
Just download the file diffoffice.sh, make it executable with `chmod +x ./diffoffice.sh` and run it.

## Usage
`./diffoffice.sh <file1> <file2>`

Without arguments, it shows a short help message.

## Limitations
It depends much on DiffPDF and its settings how good the comparison is.
While it works very well for texts, differences of images are detected but it is not shown in which part of the image the differences are occurring.

To improve the results it can help to switch between the `Words`, `Characters` and `Appearance` mode of DiffPDF.

## More informations
The difffoffice.sh file itself contains a short help, a description and a changelog.


