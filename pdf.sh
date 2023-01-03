#!/bin/bash
#todo fix 5. options

# Check if the user is running the script as root
if [[ $(id -u) -ne 0 ]]
then
    echo "This script must be run as root. Try again with 'sudo'."
    exit 1
fi


echo "Options:"
echo "1) Merge 2 pdf."
echo "2) Split 1 pdf to 2 pdf."
echo "3) Add page numbers to pdf."
echo "4) Reduce pdf file size without any quality degradation. To do this, you have to have a page number template named page_number.pdf"
#echo "5) Convert pdf file to another file. (docx, ppt, xlsx, odt, ods, odp, html, txt, jpeg, png, tiff)"




echo "Please select what you need: "
read option



#? merge

if [ $option -eq 1 ]; then
    
    # Get file names from user
    echo "Please enter the name of the first file: "
    read file1
    echo "Please enter the name of the second file: "
    read file2
    
    
    if [ ! -f "$file1" ]; then
        echo "Error: File not found."
        exit 1
    fi
    
    if [ ! -f "$file2" ]; then
        echo "Error: File not found."
        exit 1
    fi
    
    
    # Merge files
    pdftk $file1 $file2 cat output merged.pdf
    
    echo "The files have been merged into merged.pdf"
    
    
    
    
    
    
    
    
    
    
    
    #?split
    
    elif [ $option -eq 2 ]; then
    
    # Get file name from user
    echo "Please enter the name of the file to split: "
    read file
    
    if [ ! -f "$file" ]; then
        echo "Error: File not found."
        exit 1
    fi
    
    # Get page number to split at from user
    echo "Please enter the page number to split at: "
    read page
    
    # Get number of pages in PDF file
    pages=$(pdftk "$file" dump_data | grep NumberOfPages | awk '{print $2}')
    
    # Check if number is greater than or equal to number of pages
    if [ $page -ge $pages ]; then
        # Number is invalid
        echo "Error: Number must be less than the number of pages in the PDF file."
    fi
    # Split file into two
    pdftk $file cat 1-$page output "$file-1.pdf"
    pdftk $file cat $page-end output "$file-2.pdf"
    
    echo "$file has been successfully split and $file-1.pdf and $file-2.pdf have been created."
    
    
    
    
    #? adding page numbers
    
    elif [ $option -eq 3 ]; then
    
    # Get file name from user
    echo "Please enter the name of the file to add page numbers to: "
    read file
    
    if [ ! -f "$file" ]; then
        echo "Error: File not found."
        exit 1
    fi
    
    # Add page numbers to file
    pdftk $file stamp page_number.pdf output numbered.pdf
    
    echo "Page numbers have been added to $file and the resulting file has been saved as numbered.pdf."
    
    
    
    
    
    #? compress
    
    elif [ $option -eq 4 ]; then
    
    
    
    
    
    # Get file name from user
    echo "Please enter the name of the file to reduce: "
    read file
    
    if [ ! -f "$file" ]; then
        echo "Error: File not found."
        exit 1
    fi
    
    # Reduce file size with Ghostscript
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=reduced.pdf $file
    
    echo "$file has been successfully reduced and reduced.pdf has been created."
    
    
    
    #? pdf to docx, ppt, xlsx, odt, ods, odp, html, txt, jpeg, png, tiff
    
 #   elif [ $option -eq 5 ]; then
    
    
    
#   
    
    # Get file name and desired format from user
#    echo "Please enter the name of the file to convert: "
#    read file
    
#    if [ ! -f "$file" ]; then
#        echo "Error: File not found."
#        exit 1
#    fi
    
#    echo "Please enter the desired format (e.g. docx, pptx): "
#    read format
    
#    if ! [ "$format" = "docx" ] || [ "$format" = "ppt" ] || [ "$format" = "xlsx" ] || [ "$format" = "odt" ] || [ "$format" = "odt" ] || [ "$format" = "odp" ] || [ "$format" = "html" ] || [ "$format" = "txt" ] || [ "$format" = "jpeg" ] || [ "$format" = "png" ] || [ "$format" = "tiff" ]; then  # String is valid
#        echo "This format is unavailable."
#    fi
    
#    # Convert file with unoconv
#    unoconv -f $format $file
    
#    echo "$file has been successfully converted to a $format file."
    
    
#else
    # Handle invalid input
#    echo "Invalid option selected."
#fi





