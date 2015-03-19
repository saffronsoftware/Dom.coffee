# Dom.coffee v1.0.1 #
Dom = {}

###
Stores display data for elements (used for `show()` and `hide()`).
###
Dom.elemData = {}

Dom.hide = (el) ->
  ###
  Hides the given `el`, storing its display value in order to be able to
  restore it when `show()`ing the element.
  ###
  Dom.elemData[el] ||= {}
  if !el.style.display || el.style.display == 'none'
    Dom.elemData[el].oldDisplay = 'block'
  else
    Dom.elemData[el].oldDisplay = el.style.display
  el.style.display = 'none'

Dom.show = (el) ->
  ###
  Shows the given `el`, using its previous display value if we have it,
  or a default of "block".
  ###
  if Dom.elemData[el]? && Dom.elemData[el].oldDisplay?
    el.style.display = Dom.elemData[el].oldDisplay
  else
    el.style.display = 'block'

Dom.empty = (el) ->
  ###
  Empties `el`'s contents.
  ###
  el.innerHTML = ''

Dom.html = (el, html) ->
  ###
  Sets `el`'s HTML to `html`.
  ###
  el.innerHTML = html

Dom.append = (el, child) ->
  ###
  Appends `elChild` to `elParent`.
  ###
  el.appendChild(child)

Dom.appendHTML = (el, html) ->
  ###
  Appends `html` to `el`'s HTML.
  ###
  el.innerHTML ||= ''
  el.innerHTML += html

Dom.delete = (el) ->
  ###
  Deletes element `el`.
  ###
  el.parentNode.removeChild(el)

Dom.disable = (el) ->
  ###
  Sets `el`'s "disabled" attribute to "disabled".
  ###
  el.setAttribute('disabled', 'disabled')

Dom.enable = (el) ->
  ###
  Removes `el`'s "disabled" attribute".
  ###
  el.removeAttribute('disabled')

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

Dom.matches = (el, selector) ->
  ###
  Returns true if `el` matches `selector`.
  Adapted from https://developer.mozilla.org/en-US/docs/Web/API/Element/matches
  ###
  matches = (el.parentNode || el.document || el.ownerDocument).querySelectorAll(selector)
  i = 0
  while matches[i] && matches[i] != el
    i++
  return matches[i]?

Dom.closestParent = (el, selector) ->
  ###
  Returns `el`'s first parent that matches `selector`, or null if none is found.
  TODO: Add polyfills here.
  ###
  while el
    el = el.parentNode
    return el if Dom.matches(el, selector)
  return null

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
