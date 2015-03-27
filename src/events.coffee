do ->
  bind = (el, type, handler) ->
    if el.addEventListener
      el.addEventListener(type, handler, false)
    else if el.attachEvent
      el.attachEvent('on' + type, handler)
    else
      el['on' + type] = handler

  Dom.prototype.extend {
    bind: (type, handler) ->
      @map (el) -> bind(el, type, handler)
  }
