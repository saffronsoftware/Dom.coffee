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
      throw new Error('Dom.coffee: Invalid argument to .append(), must be either string or DOM element')

  appendTo = (el, parent) ->
    parent.appendChild(el)

  getAttribute = (el, name) -> el.getAttribute(name)

  setAttribute = (el, name, value) -> el.setAttribute(name, value)

  removeAttribute = (el, name) -> el.removeAttribute(name)

  disable = (el) -> setAttribute(el, 'disabled', 'disabled')

  enable = (el) -> removeAttribute(el, 'disabled')

  remove = (el) -> el.parentNode.removeChild(el)

  setValue = (el, value) -> el.value = value

  getValue = (el) ->
    if el.tagName.toLowerCase() == 'input'
      if el.type.toLowerCase() == 'text' || el.type.toLowerCase() == 'password'
        return el.value
      if el.type.toLowerCase() == 'checkbox'
        return el.checked
    if el.tagName.toLowerCase() == 'textarea'
      return el.value
    if el.tagName.toLowerCase() == 'select'
      return el.options[el.selectedIndex].value
    return undefined

  Dom.prototype.extend {
    empty: ->
      @map(empty)
      return this
    html: (content) ->
      @map (el) -> html(el, content)
      return this
    append: (content) ->
      @map (el) -> append(el, content)
      return this
    appendTo: (parent) ->
      @map (el) -> appendTo(el, parent)
      return this
    attr: (name, value) ->
      if value?
        @map (el) -> setAttribute(el, name, value)
        return this
      else
        @map (el) -> getAttribute(el, name)
    removeAttr: (name) ->
      @map (el) -> removeAttribute(el, name)
      return this
    disable: ->
      @map(disable)
      return this
    enable: ->
      @map(enable)
      return this
    remove: ->
      @map(remove)
      return this
    value: (value) ->
      if value?
        @map (el) -> setValue(el, value)
        return this
      else
        @map (el) -> getValue(el)
  }
