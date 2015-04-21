do ->
  empty = (el) -> el.innerHTML = ''

  html = (el, content) -> el.innerHTML = content

  append = (el, content) ->
    if typeof content == 'string'
      el.innerHTML ||= ''
      el.innerHTML += content
    else if Dom.isElement(content)
      el.appendChild(content)
    else if content instanceof Dom
      content.map (appendee) ->
        el.appendChild(appendee)
    else
      throw new Error('Dom.coffee: Invalid argument to .append(), must be either string, DOM element or Dom instance')

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
      @imap(empty)
      return this
    html: (content) ->
      @imap (el) -> html(el, content)
      return this
    append: (content) ->
      @imap (el) -> append(el, content)
      return this
    appendTo: (parent) ->
      @imap (el) -> appendTo(el, parent)
      return this
    attr: (name, value) ->
      if value?
        @imap (el) -> setAttribute(el, name, value)
        return this
      else
        @imap (el) -> getAttribute(el, name)
    removeAttr: (name) ->
      @imap (el) -> removeAttribute(el, name)
      return this
    disable: ->
      @imap(disable)
      return this
    enable: ->
      @imap(enable)
      return this
    remove: ->
      @imap(remove)
      return this
    value: (value) ->
      if value?
        @imap (el) -> setValue(el, value)
        return this
      else
        @imap (el) -> getValue(el)
  }
