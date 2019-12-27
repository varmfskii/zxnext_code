#!/bin/bash

build() {
    pdflatex zxnext_notes.tex
    pdflatex zxnext_notes.tex
    makeindex zxnext_notes.idx
    pdflatex zxnext_notes.tex
    latex2html zxnext_notes.tex
}

test_action() {
    echo test action
}

cleanup() {
    echo cleanup
    find . -name "*~" -delete
    find . -name "*.aux" -delete
    rm -f zxnext_notes.idx zxnext_notes.ilg zxnext_notes.ind
    rm -f zxnext_notes.lof zxnext_notes.log zxnext_notes.lot
    rm -f zxnext_notes.toc
}

usage() {
    cat <<EOF
usage: $0 <options>
where options are:
build: make the document
clean: remove extra files from build
cleanall: remove all files from build
help: print this usage information

If no option is given, the document is built
EOF
}

hasopt="false"
for opt in "$@";
do
    case "$opt" in
	build ) build ;;
	clean ) cleanup ;;
	* ) usage
    esac
    hasopt="true"
done

if [ $hasopt != "true" ]
then 
    build
fi	
