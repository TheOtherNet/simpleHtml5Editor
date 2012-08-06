# Makefile for simpleHtml5Editor persistence plugin

all: build compress

compress:
	yui-compressor --type js js/simpleHtml5Editor.js > js/simpleHtml5Editor.min.js
	yui-compressor --type css css/simpleHtml5Editor.css > css/simpleHtml5Editor.min.css

build:
	mkdir js css
	coffee --join ./js/simpleHtml5Editor.js --compile coffee/*.coffee
	lessc less/main.less css/simpleHtml5Editor.css

clean:
	rm -rf css/simpleHtml5Editor.css css/simpleHtml5Editor.min.css js/simpleHtml5Editor.js js/simpleHtml5Editor.min.js

.PONY: clean build compress all
