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

  getAttribute = (el, attr) -> el.getAttribute(attr)

  setAttribute = (el, attr, value) -> el.setAttribute(attr, value)

  removeAttribute = (el, attr) -> el.removeAttribute(attr)

  disable = (el) -> setAttribute(el, 'disabled', 'disabled')

  enable = (el) -> removeAttribute(el, 'disabled')

  remove = (el) -> el.parentNode.removeChild(el)

  Dom.prototype.extend {
    empty: -> @map(empty)
    html: (content) ->
      @map (el) -> html(el, content)
    append: (content) ->
      @map (el) -> append(el, content)
    appendTo: (parent) ->
      @map (el) -> appendTo(el, parent)
    attr: (attr, value) ->
      if value?
        @map (el) -> setAttribute(el, attr, value)
      else
        @map (el) -> getAttribute(el, attr)
    disable: -> @map(disable)
    enable: -> @map(enable)
    remove: -> @map(remove)
  }
