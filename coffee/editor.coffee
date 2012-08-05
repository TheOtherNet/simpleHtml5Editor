class SimpleHtml5Editor
  constructor: (@element, movement) ->
    button_creator = [
      { 'tag' : 'bold', 'format': '', 'name' : '<i class="icon-bold"></i>' },
      { 'tag' : 'underline', 'format': '', 'name' : '<ins>U</ins>' },
      { 'tag' : 'strikeTrough', 'format': '', 'name' : '<del>S</del>' },
      { 'tag' : 'formatBlock', 'format': 'h1', 'name' : '<strong>h1</strong>' },
      { 'tag' : 'justifyRight', 'format': '', 'name' : '<i class="icon-align-left"></i>' },
      { 'tag' : 'justifyCenter', 'format': '', 'name' : '<i class="icon-align-center"></i>' },
      { 'tag' : 'justifyLeft', 'format': '', 'name' : '<i class="icon-align-right"></i>' },
    ]
    @element.prepend('<a class="editor-button" href="#" data-format=\"' + btn['format'] + \
      '\" data-tag=\"' + btn['tag'] + '\"  >' + btn['name'] + '</a>') for btn in button_creator
    buttons = $(@element).children('.editor-button')
    ($ button).on 'click', @execcmd for button in buttons

  execcmd: (ev) ->
    target = ($ ev.target).parent()[0]
    langs = [ 'Enter URL', 'Enter Image URL' ]
    tag = target.dataset['tag']
    if tag == "formatBlock"
      data = target.dataset['format']
    else if tag in [ 'createlink', 'insertImage' ]
      data = prompt(langs[tag])
    if data
      return document.execCommand(tag, false, data)
    document.execCommand(tag, false)

do ($) ->
  $.fn.simpleHtml5Editor = () ->
    simpleHtml5Editor = new SimpleHtml5Editor(@)
