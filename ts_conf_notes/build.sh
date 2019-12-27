#!/bin/bash
pdflatex tsconf_notes.tex
pdflatex tsconf_notes.tex
makeindex tsconf_notes.idx
pdflatex tsconf_notes.tex
latex2html tsconf_notes.tex
