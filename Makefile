.PHONY : clean veryclean

LATEX=latex
BIBTEX=bibtex
PDF_PRODUCER=pdflatex
PS2PDF=ps2pdf
PDF_VIEWER=evince

all : EJ-Paper.pdf

help :
	@echo "Makefile generique pour les fichiers LaTex"
	@echo "cibles : clean, veryclean, *.dvi, ..."

clean :
	-\rm -f *~ *.log *.aux *.toc *.ilg *.idx *.bbl *.blg *.lof *.thm *.spl

veryclean : clean
	-\rm -f *.pdf *.ps *.dvi

%.pdf : veryclean
	$(PDF_PRODUCER) $*.tex
	$(BIBTEX) $*
	$(PDF_PRODUCER) $*.tex
	$(PDF_PRODUCER) $*.tex

%.dvi : %.tex
	$(LATEX) $*.tex
	$(BIBTEX) $*
	$(LATEX) $*.tex
	$(LATEX) $*.tex

%.ps : %.dvi
	dvips $*.dvi -o $*.ps

%.pdfe : %.ps
	$(PS2PDF) $*.ps $*.pdf

%.view : %.pdf
	$(PDF_VIEWER) $<
