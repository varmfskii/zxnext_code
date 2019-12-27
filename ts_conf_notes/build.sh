#!/bin/bash
pdflatex ts_conf_notes.tex
pdflatex ts_conf_notes.tex
makeindex ts_conf_notes.idx
pdflatex ts_conf_notes.tex
latex2html ts_conf_notes.tex
