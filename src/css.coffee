do ->
  getStyle = (el, name) ->
    ###
    Falls back to using getComputedStyle if `el.style` doesn't have what we
    need. Perhaps consider optimising this.
    ###
    if el.style[name]? && el.style[name].length > 0
      return el.style[name]
    else
      return getComputedStyle(el).getPropertyValue(name)

  setStyle = (el, name, value) ->
    el.style[name] = value

  hide = (el) ->
    return if !isVisible(el)
    display = getStyle(el, 'display')
    Dom.setElemData(el, 'oldDisplay', display) if display != 'none'
    setStyle(el, 'display', 'none')

  show = (el) ->
    return if isVisible(el)
    newDisplay = Dom.getElemData(el, 'oldDisplay') ||
                 Dom.getDefaultDisplay(el.tagName)
    setStyle(el, 'display', newDisplay)

  isVisible = (el) ->
    getStyle(el, 'display') != 'none'

  toggle = (el) ->
    if isVisible(el)
      hide(el)
    else
      show(el)

  Dom.prototype.extend {
    style: (name, value) ->
      if value?
        @map (el) -> setStyle(el, name, value)
      else
        @map (el) -> getStyle(el, name)
    show: -> @map(show)
    hide: -> @map(hide)
    isVisible: -> @map(isVisible)
    toggle: -> @map(toggle)
  }
