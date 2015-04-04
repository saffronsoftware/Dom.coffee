do ->
  empty = (el) -> el.innerHTML = ''

  html = (el, content) -> el.innerHTML = content

  append = (el, content) ->
    if typeof content == 'string'
      el.innerHTML ||= ''
      el.innerHTML += content
    else if Dom.isElement(content)
      el.appendChild(content)
    else
      throw new Exception("Invalid argument")

  appendTo = (el, parent) ->
    parent.appendChild(el)

  getAttribute = (el, name) -> el.getAttribute(name)

  setAttribute = (el, name, value) -> el.setAttribute(name, value)

  removeAttribute = (el, name) -> el.removeAttribute(name)

  disable = (el) -> setAttribute(el, 'disabled', 'disabled')

  enable = (el) -> removeAttribute(el, 'disabled')

  remove = (el) -> el.parentNode.removeChild(el)

  setValue = (el, value) -> el.value = value

  getValue = (el) -> el.value

  Dom.prototype.extend {
    empty: -> @map(empty)
    html: (content) ->
      @map (el) -> html(el, content)
    append: (content) ->
      @map (el) -> append(el, content)
    appendTo: (parent) ->
      @map (el) -> appendTo(el, parent)
    attr: (name, value) ->
      if value?
        @map (el) -> setAttribute(el, name, value)
      else
        @map (el) -> getAttribute(el, name)
    removeAttr: (name) ->
      @map (el) -> removeAttribute(el, name)
    disable: -> @map(disable)
    enable: -> @map(enable)
    remove: -> @map(remove)
    value: (value) ->
      if value?
        @map (el) -> setValue(el, value)
      else
        @map (el) -> getValue(el)
  }
