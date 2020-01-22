MAIN = skeleton
NAME = PoS 
CLSFILES = $(NAME).cls

SHELL = bash
LATEXMK = latexmk -pdf -bibtex 
TEXMF = $(shell kpsewhich --var-value TEXMFHOME)

.PHONY : main cls doc test save clean all install distclean zip FORCE_MAKE

main : $(MAIN).pdf

all : main

cls : $(CLSFILES) 

$(MAIN).pdf : $(MAIN).tex 
	$(LATEXMK) $<

test:
	texlua test/build.lua check
	texlua test/build-toc.lua check
	texlua test/build-bib.lua check
	# texlua test/build-nomencl.lua check

save:
	texlua test/build.lua save --quiet titlepage
	texlua test/build.lua save --quiet titlepage-master
	texlua test/build.lua save --quiet titlepage-secret
	texlua test/build.lua save --quiet titlepage-bachelor
	texlua test/build.lua save --quiet statement
	texlua test/build.lua save --quiet statement-secret
	texlua test/build.lua save --quiet package-siunitx
	texlua test/build-toc.lua save --quiet main
	texlua test/build-toc.lua save --quiet main-english
	texlua test/build-toc.lua save --quiet main-bachelor
	texlua test/build-toc.lua save --quiet main-bachelor-arabic
	texlua test/build-toc.lua save --quiet main-bachelor-english
	texlua test/build-toc.lua save --quiet main-lof
	texlua test/build-toc.lua save --quiet main-lot
	texlua test/build-bib.lua save --quiet bib-super
	texlua test/build-bib.lua save --quiet bib-numbers
	texlua test/build-bib.lua save --quiet bib-authoryear
	texlua test/build-bib.lua save --quiet bib-bachelor
	texlua test/build-nomencl.lua save --quiet package-nomencl

clean : FORCE_MAKE
	$(LATEXMK) -c $(MAIN).tex
	texlua test/build.lua clean

distclean :
	$(LATEXMK) -C $(MAIN).tex
	texlua test/build.lua clean

