do ->
  # Many things in here heavily inspired by jQuery.
  reNotWhitespace = /\S+/g

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

  trimClass = (cls) ->
    cls.replace(/[\t\r\n\f]/g, ' ')

  spaceClass = (cls) ->
    if cls
      ' ' + trimClass(cls) + ' '
    else
      ' '

  containsClass = (parent, child) ->
    spaceClass(parent).indexOf(spaceClass(child)) != -1

  hasClass = (el, cls) ->
    containsClass(el.className, cls)

  removeClass = (el, strClasses) ->
    classes = strClasses.match(reNotWhitespace) || []
    return if classes.length == 0
    classes.map (cls) ->
      return if !hasClass(el, cls)
      newClassName = el.className
      while containsClass(newClassName, cls)
        newClassName = spaceClass(newClassName).replace(spaceClass(cls), ' ')
      el.className = newClassName.trim()

  addClass = (el, strClasses) ->
    classes = strClasses.match(reNotWhitespace) || []
    return if classes.length == 0
    classes.map (cls) ->
      return if hasClass(el, cls)
      newClassName = spaceClass(el.className) + cls + ' '
      el.className = newClassName.trim()

  toggleClass = (el, strClasses) ->
    classes = strClasses.match(reNotWhitespace) || []
    return if classes.length == 0
    classes.map (cls) ->
      if hasClass(el, cls)
        removeClass(el, cls)
      else
        addClass(el, cls)

  offset = (el) ->
    box = el.getBoundingClientRect()
    {
      top: box.top + window.pageYOffset - document.documentElement.clientTop
      left: box.left + window.pageXOffset - document.documentElement.clientLeft
    }

  pxToNumber = (px) ->
    +(px.replace('px', ''))

  height = (el) ->
    if el == window
      window.innerHeight ||
      (document.documentElement &&
       document.documentElement.clientHeight) ||
      document.body.clientHeight
    else
      pxToNumber(getStyle(el, 'height'))

  width = (el) ->
    if el == window
      window.innerWidth ||
      (document.documentElement &&
       document.documentElement.clientWidth) ||
      document.body.clientWidth
    else
      pxToNumber(getStyle(el, 'width'))

  Dom.prototype.extend {
    style: (name, value) ->
      if value?
        @imap (el) -> setStyle(el, name, value)
        return this
      else
        @imap (el) -> getStyle(el, name)
    height: ->
       @imap(height)
    width: ->
       @imap(width)
    show: ->
      @imap(show)
      return this
    hide: ->
      @imap(hide)
      return this
    isVisible: ->
      @imap(isVisible)
    toggle: ->
      @imap(toggle)
      return this
    addClass: (cls) ->
      @imap (el) -> addClass(el, cls)
      return this
    removeClass: (cls) ->
      @imap (el) -> removeClass(el, cls)
      return this
    toggleClass: (cls) ->
      @imap (el) -> toggleClass(el, cls)
      return this
    hasClass: (cls) ->
      @imap (el) -> hasClass(el, cls)
    offset: ->
      @imap(offset)
  }

  scrollTop = ->
    (document.documentElement &&
     document.documentElement.scrollTop) ||
    document.body.scrollTop

  Dom.extend {
    scrollTop: scrollTop
  }
