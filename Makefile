# Makefile for simpleHtml5Editor persistence plugin

all: build compress

compress:
	yui-compressor --type js ./simpleHtml5Editor.js > simpleHtml5Editor.min.js
	yui-compressor --type css simpleHtml5Editor.css > simpleHtml5Editor.min.css

build:
	coffee --join ./simpleHtml5Editor.js --compile coffee/*.coffee
	lessc less/main.less simpleHtml5Editor.css

clean:
	rm simpleHtml5Editor.js simpleHtml5Editor.min.js simpleHtml5Editor.css simpleHtml5Editor.min.css

.PONY: clean build compress all
