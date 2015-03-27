do ->
  getDefaultDisplay = (nodeName) ->
    ###
    If we don't already know the default display, try making an element with
    that nodeName and getting its display.
    ###
    return Dom.defaultDisplays[nodeName] if Dom.defaultDisplays[nodeName]?

    el = Dom(document.createElement(nodeName))
    el.appendTo(document.body)
    display = el.style('display')
    Dom.defaultDisplays[nodeName] = display
    el.remove()

    display ||= 'block'

    ###
    Apparently the createElement method may fail, and we would have to read
    the value from inside an iframe. Maybe account for this at some point.
    ###
    return display

  Dom.extend {
    defaultDisplays: {
      # HTML and BODY must be defined for Firefox
      HTML: 'block'
      BODY: 'block'
    }
    getDefaultDisplay: getDefaultDisplay
  }
