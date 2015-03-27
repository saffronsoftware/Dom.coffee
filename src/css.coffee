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
    Dom.setElemData(el, 'oldDisplay', getStyle(el, 'display'))
    setStyle(el, 'display', 'none')

  show = (el) ->
    setStyle(el, 'display', Dom.getElemData(el, 'oldDisplay') || '')

  isVisible = (el) ->
    getStyle(el, 'display') == 'none'

  toggle = (el) ->
    if isVisible(el)
      hide(el)
    else
      show(el)

  Dom.prototype.extend {
    style: (name, value) ->
      if value?
        @map (el) -> getStyle(el, name)
      else
        @map (el) -> setStyle(el, name, value)
    show: -> @map(show)
    hide: -> @map(hide)
    isVisible: -> @map(isVisible)
    toggle: -> @map(toggle)
  }
