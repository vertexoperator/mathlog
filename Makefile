SRCS = LinearAlgebra.md 

.SUFFIXES:	.md .html
.md.html:
	pandoc -f markdown -t html --template=./template --mathjax -o $@ $<
all:	$(SRCS:.md=.html)

clean:
	rm LinearAlgebra.html
