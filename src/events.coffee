Dom.bind = (el, type, handler) ->
  ###
  Attach a handler of type `type` with function `handler` to element `el`.
  ###
  return if !el?
  if el.addEventListener
    el.addEventListener(type, handler, false)
  else if el.attachEvent
    el.attachEvent('on' + type, handler)
  else
    el['on' + type] = handler

Dom.bindAll = (els, type, handler) ->
  ###
  Bind for each element in `els`.
  ###
  [].forEach.call els, (el) ->
    Dom.bind(el, type, handler)
