#!/bin/bash
pdflatex 000-document.tex
pdflatex 000-document.tex
makeindex 000-document.idx
pdflatex 000-document.tex
latex2html 000-document.tex
