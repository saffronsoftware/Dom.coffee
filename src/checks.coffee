Dom.isNode = (el) ->
  ###
  Returns true if `el` is a DOM Node.
  ###
  if typeof Node == 'object'
    el instanceof Node
  else
    el && typeof el == 'object' && typeof el.nodeType == 'number' &&
    typeof el.nodeName == 'string'

Dom.isElement = (el) ->
  ###
  Returns true if `el` is a DOM element.
  ###
  if typeof HTMLElement == 'object'
    el instanceof HTMLElement
  else
    el && typeof el == 'object' && el != null && el.nodeType == 1 &&
    typeof el.nodeName == 'string'
