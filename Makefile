MARKDOWN = pandoc --from markdown --to html -s -S --toc -c http://hive.3du.me/pandoc.css  
all: $(patsubst %.md,%.html,$(wildcard *.md)) Makefile

clean:
	rm -f $(patsubst %.md,%.html,$(wildcard *.md))
	rm -f *.bak *~
	rm -f slide.html

%.html: %.md
	$(MARKDOWN) $< --output $@
