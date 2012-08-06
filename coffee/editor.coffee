class SimpleHtml5Editor
  constructor: (@element, movement) ->
    @langs = [ 'Enter URL', 'Enter Image URL' ]
    @button_creator = [
      { 'tag' : 'bold', 'format': '', 'name' : '<i class="icon-bold"></i>' },
      { 'tag' : 'underline', 'format': '', 'name' : '<ins>U</ins>' },
      { 'tag' : 'strikeTrough', 'format': '', 'name' : '<del>S</del>' },
      { 'tag' : 'subscript', 'format': '', 'name' : 'T<sub>x</sub>' },
      { 'tag' : 'superscript', 'format': '', 'name' : 'T<sup>x</sub>' },
      { 'tag' : 'indent', 'format': '', 'name' : '<b class=icon-indent-left></b>' },
      { 'tag' : 'outdent', 'format': '', 'name' : '<b class=icon-indent-right></b>' },
      {
        '<b class=icon-text-height></b>' : [{ 'tag' : 'formatBlock', 'format': 'p', 'name' : 'Paragraph' },
        { 'tag' : 'formatBlock', 'format': 'h1', 'name' : 'Header' },
        { 'tag' : 'formatBlock', 'format': 'h2', 'name' : 'Header 2' },
        { 'tag' : 'formatBlock', 'format': 'h3', 'name' : 'Header 3' },]
      },
      { 'tag' : 'justifyRight', 'format': '', 'name' : '<i class="icon-align-left"></i>' },
      { 'tag' : 'justifyCenter', 'format': '', 'name' : '<i class="icon-align-center"></i>' },
      { 'tag' : 'justifyLeft', 'format': '', 'name' : '<i class="icon-align-right"></i>' },
    ]
    @create_button(btn) for btn in @button_creator
    ($ '.editor-button').on 'click', @execcmd
    ($ '.editor_nav').on 'change', @execcmd

  create_button: (btn) ->
    if btn['tag']
      html = '<a class="editor-button" href="#" data-format=\"' + btn['format'] + \
        '\" data-tag=\"' + btn['tag'] + '\"  >' + btn['name'] + '</a>'
    else
      html = "<select class='editor_nav'>"
      html += '<option data-format=\"' + element[elem]['format'] + \
          '\" data-tag=\"' + element[elem]['tag'] + '\"  >' + element[elem]['name'] + '</option>'\
          for elem of element for name, element of btn
      html += "</select>"
    @element.prepend(html)

  execcmd: (ev) ->
    target = ev.target
    if ($ target) .is 'select'
      target = target[target.selectedIndex]
    tag = target.dataset['tag']

    if tag == "formatBlock"
      data = target.dataset['format']
    else if tag in [ 'createlink', 'insertImage' ]
      data = prompt(@langs[tag])
    console.log target
    console.log tag
    console.log data
    if data
      return document.execCommand(tag, false, data)
    document.execCommand(tag, false)

do ($) ->
  $.fn.simpleHtml5Editor = () ->
    simpleHtml5Editor = new SimpleHtml5Editor(@)
