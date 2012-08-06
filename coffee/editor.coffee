class SimpleHtml5Editor
  constructor: (@element, movement) ->
    @langs = [ 'Enter URL', 'Enter Image URL' ]
    @button_creator = [
      { 'editor_formatting': [
        { 'tag' : 'bold', 'format': '', 'name' : '<i class="icon-bold"></i>' },
        { 'tag' : 'underline', 'format': '', 'name' : '<i class="icon-underline"></i>' },
        { 'tag' : 'strikeThrough', 'format': '', 'name' : '<i class="icon-strikethrough"></i>' },
        { 'tag' : 'subscript', 'format': '', 'name' : 'T<sub>x</sub>' },
        { 'tag' : 'superscript', 'format': '', 'name' : 'T<sup>x</sub>' },]
      },
      { 'editor_indentation' : [
        { 'tag' : 'indent',  'format': '', 'name' : '<b class=icon-indent-left></b>' },
        { 'tag' : 'outdent', 'format': '', 'name' : '<b class=icon-indent-right></b>' },]}
      { 'editor_justify' : [{ 'tag' : 'justifyLeft',  'format': '', 'name' : '<i class="icon-align-left"></i>'   },
        { 'tag' : 'justifyCenter', 'format': '', 'name' : '<i class="icon-align-center"></i>' },
        { 'tag' : 'justifyRight',  'format': '', 'name' : '<i class="icon-align-right"></i>'  },]
      },
      { 'select' : [{ 'tag' : 'formatBlock', 'format': 'p', 'name' : '<i class="icon-paragraph"></i>Paragraph' },
        { 'tag' : 'formatBlock', 'format': 'h1', 'name' : 'Header' },
        { 'tag' : 'formatBlock', 'format': 'h2', 'name' : 'Header 2' },
        { 'tag' : 'formatBlock', 'format': 'h3', 'name' : 'Header 3' },]
      },
    ]
    @create_button(btn) for btn in @button_creator
    ($ '.editor_button').on 'click', @execcmd
    ($ '.editor_nav').on 'change', @execcmd

  create_group: (name, element) ->
    html = "<div class='editor_group " + name + "'>"
    html += '<a href=# class=editor_button data-format=\"' + element[elem]['format'] + \
        '\" data-tag=\"' + element[elem]['tag'] + '\"  >' + element[elem]['name'] + '</a>'\
        for elem of element
    html += "</div>"
    return html

  create_select: (element) ->
    html = "<select class='editor_nav'>"
    html += '<option data-format=\"' + element[elem]['format'] + \
        '\" data-tag=\"' + element[elem]['tag'] + '\"  >' + element[elem]['name'] + '</option>'\
        for elem of element
    html += "</select>"
    return html

  create_button: (btn) ->
    if btn['tag']
      html = '<a class="editor_button" href="#" data-format=\"' + btn['format'] + \
        '\" data-tag=\"' + btn['tag'] + '\"  >' + btn['name'] + '</a>'
    else
      console.log name, element for name, element of btn
      html = @create_select(element) for name, element of btn if name == "select"
      html = @create_group(name, element) for name, element of btn if name != "select"
    @element.prepend(html)

  execcmd: (ev) ->
    target = ev.target
    if ($ target) .is 'select'
      target = target[target.selectedIndex]
    else if not ($ target) .is 'a'
      target = ($ target).parent()[0]
    else if not ($ target) .is 'a'
      target = ($ target).parent()[0]
    tag = target.dataset['tag']
    console.log target

    if tag == "formatBlock"
      data = target.dataset['format']
    else if tag in [ 'createlink', 'insertImage' ]
      data = prompt(@langs[tag])
    if data
      return document.execCommand(tag, false, data)
    document.execCommand(tag, false)

do ($) ->
  $.fn.simpleHtml5Editor = () ->
    simpleHtml5Editor = new SimpleHtml5Editor(@)
