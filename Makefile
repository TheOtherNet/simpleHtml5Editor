# Makefile for simpleHtml5Editor persistence plugin

all: build compress

compress:
	yui-compressor --type js $(dir_)js/simpleHtml5Editor.js > $(dir_)js/simpleHtml5Editor.min.js
	yui-compressor --type css $(dir_)css/simpleHtml5Editor.css > $(dir_)css/simpleHtml5Editor.min.css

build: dirs
	coffee --join $(dir_)js/simpleHtml5Editor.js --compile coffee/*.coffee
	lessc less/main.less $(dir_)css/simpleHtml5Editor.css
	cp -r less/font-awesome/font $(dir_)css/

dirs:
	@mkdir $(dir_)js $(dir_)css &>/dev/null

clean:
	rm -rf css/simpleHtml5Editor.css css/simpleHtml5Editor.min.css js/simpleHtml5Editor.js js/simpleHtml5Editor.min.js

.PONY: clean build compress all
