###
Dom.coffee
https://github.com/vladh/Dom.coffee
###

Dom = (element) -> new Dom.prototype.init(element)

Dom.extend = Dom.prototype.extend = ->
  nrArgs = arguments.length
  if nrArgs == 1
    target = this
    source = arguments[0]
  else
    target = arguments[0]
    source = arguments[1]

  for key, value of source
    target[key] = value
  return target

Dom.prototype.init = (element) ->
  ###
  Takes either a DOM element or an array of DOM elements or NodeList a selector.
  @els is the list of elements for this instance.
  @elemData stores various data stored for elements (e.g. old display value).
  ###
  invalidArgumentMessage = 'Dom.coffee: Invalid argument to .init(), must be one of:
                            a DOM element, an array of DOM elements, a NodeList, a
                            selector, `document` or `window`.'

  throw new Error(invalidArgumentMessage) if !element?

  return element if element.constructor? && element.constructor == Dom

  if Dom.isNode(element) || element == window || element == document
    @els = [element]
  else if element.constructor == Array && element.every(Dom.isNode)
    @els = element
  else if Dom.isNodeList(element)
    @els = [].slice.call(element)
  else if Dom.isSelector(element)
    @els = [].slice.apply(document.querySelectorAll(element))
  else
    throw new Error(invalidArgumentMessage)

  return this

# This is for instantiation
Dom.prototype.init.prototype = Dom.prototype

Dom.prototype.extend {
  map: ->
    @els.map.apply(@els, arguments)
  reduce: ->
    @els.reduce.apply(@els, arguments)
  filter: ->
    @els.filter.apply(@els, arguments)
  imap: ->
    results = @map.apply(this, arguments)
    return results[0] if results.length == 1
    return results
}

Dom.extend {
  elemData: {}
  getElemData: (el, key) ->
    if Dom.elemData[el]? && Dom.elemData[el][key]?
      Dom.elemData[el][key]
    else
      null
  setElemData: (el, key, value) ->
    Dom.elemData[el] ||= {}
    Dom.elemData[el][key] ||= {}
    Dom.elemData[el][key] = value
}
