do ->
  isNode = (el) ->
    if typeof Node == 'object'
      el instanceof Node
    else
      el && typeof el == 'object' && typeof el.nodeType == 'number' &&
      typeof el.nodeName == 'string'

  isElement = (el) ->
    if typeof HTMLElement == 'object'
      el instanceof HTMLElement
    else
      el && typeof el == 'object' && el != null && el.nodeType == 1 &&
      typeof el.nodeName == 'string'

  isSelector = (x) ->
    ###
    This is a pretty naive check.
    ###
    return typeof x == "string"

  Dom.extend {
    isNode: isNode
    isElement: isElement
    isSelector: isSelector
  }
