do ->
  isNode = (el) ->
    if typeof Node == 'object'
      el instanceof Node
    else
      el && typeof el == 'object' && typeof el.nodeType == 'number' &&
      typeof el.nodeName == 'string'

  isNodeList = (x) ->
    ###
    From http://stackoverflow.com/q/7238177/3803222
    ###
    stringRepr = Object.prototype.toString.call(x)
    typeof x == 'object' &&
    /^\[object (HTMLCollection|NodeList|Object)\]$/.test(stringRepr) &&
    x.hasOwnProperty('length') &&
    (x.length == 0 || (typeof x[0] == "object" && x[0].nodeType > 0))

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
    isNodeList: isNodeList
    isElement: isElement
    isSelector: isSelector
  }
