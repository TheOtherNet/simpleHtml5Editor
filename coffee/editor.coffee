class SimpleHtml5Editor
  constructor: (@element, movement) ->
    @langs = [ 'Enter URL', 'Enter Image URL' ]
    @button_creator = [
      { 'editor_remove_format': [{ 'tag' : 'removeFormat', 'format': '', 'name': '<i title="Remove format in selection" class="icon-remove"></i>' }]},
      { 'editor_formatting': [
        { 'tag' : 'bold', 'format': '', 'name' : '<i title="Bold" class="icon-bold"></i>' },
        { 'tag' : 'underline', 'format': '', 'name' : '<i title="Underline" class="icon-underline"></i>' },
        { 'tag' : 'strikeThrough', 'format': '', 'name' : '<i title="Strike Trough" class="icon-strikethrough"></i>' },]}
      { 'editor_sub': [
        { 'tag' : 'subscript', 'format': '', 'name' : 'T<sub title="subscript">x</sub>' },
        { 'tag' : 'superscript', 'format': '', 'name' : 'T<sup title="superscript">x</sub>' },]
      },
      { 'editor_lists' : [
        { 'tag' : 'insertUnorderedList',  'format': '', 'name' : '<b title="Unordered list" class=icon-list-ul></b>' },
        { 'tag' : 'insertOrderedList',  'format': '', 'name' : '<b title="Ordered list" class=icon-list-ol></b>' },
      ]}
      { 'editor_indentation' : [
        { 'tag' : 'indent',  'format': '', 'name' : '<b class=icon-indent-left title="Indent"></b>' },
        { 'tag' : 'outdent', 'format': '', 'name' : '<b class=icon-indent-right title="Outdent"></b>' },]}

      { 'editor_justify' : [{ 'tag' : 'justifyLeft',  'format': '', 'name' : '<i title="Align left" class="icon-align-left"></i>'   },
        { 'tag' : 'justifyCenter', 'format': '', 'name' : '<i class="icon-align-center" title="Center"></i>' },
        { 'tag' : 'justifyRight',  'format': '', 'name' : '<i class="icon-align-right" title="Align right"></i>'  },]
      },
      { 'select' : [{ 'tag' : 'formatBlock', 'format': 'p', 'name' : 'Paragraph' },
        { 'tag' : 'formatBlock', 'format': 'h1', 'name' : 'Header' },
        { 'tag' : 'formatBlock', 'format': 'h2', 'name' : 'Header 2' },
        { 'tag' : 'formatBlock', 'format': 'h3', 'name' : 'Header 3' },]
      },
      { 'select' : [{ 'tag' : 'fontName', 'format': 'Arial', 'name' : 'Arial' },
        { 'tag' : 'fontName', 'format': 'Helvetica', 'name' : 'Helvetica' },
        { 'tag' : 'fontName', 'format': 'Times', 'name' : 'Times' },
        { 'tag' : 'fontName', 'format': 'Courier', 'name' : 'Courier' },
      ]},
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
      html = @create_group(name, element) for name, element of btn if name != "select"
      html = @create_select(element) for name, element of btn if name == "select"
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

    data = target.dataset['format']
    if tag in [ 'createlink', 'insertImage' ]
      data = prompt(@langs[tag])
    if data
      return document.execCommand(tag, false, data)
    document.execCommand(tag, false)

do ($) ->
  $.fn.simpleHtml5Editor = () ->
    simpleHtml5Editor = new SimpleHtml5Editor(@)
