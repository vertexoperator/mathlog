SRCS = LinearAlgebra.md 

.SUFFIXES:	.md .html
.md.html:
	pandoc -s --mathjax -o $@ $<
all:	$(SRCS:.md=.html)

clean:
	rm *.html
