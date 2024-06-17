#!/bin/bash

#================#
#  MakeDiagrams  #
#================#

for f in FeynmanDiagramQuadratic.tex FeynmanDiagramQuartic.tex FeynmanDiagramHexic.tex FeynmanDiagramSpin0ParityEven.tex FeynmanDiagramSpin0ParityOdd.tex FeynmanDiagramSpin1ParityEven.tex FeynmanDiagramSpin1ParityOdd.tex FeynmanDiagramSpin2ParityEven.tex FeynmanDiagramSpin2ParityOdd.tex FeynmanDiagramSpin3ParityEven.tex FeynmanDiagramSpin3ParityOdd.tex; do latexmk -pdf -interaction=nonstopmode -pdflatex=lualatex $f; done
rm -rf *.aux
rm -rf *.fdb_latexmk
rm -rf *.fls
rm -rf *.log
 
exit 0
