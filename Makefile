SRCS = LinearAlgebra.md 

.SUFFIXES:	.md .html .epub
.md.html:
	pandoc -f markdown -t html --template=./template --mathjax -o $@ $<
html:	$(SRCS:.md=.html)

#-- epubへの変換は酷い
.md.epub:
	pandoc -t epub -o $@ $<
epub:   $(SRCS:.md=.epub)


clean:
	rm LinearAlgebra.html
