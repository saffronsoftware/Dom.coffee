Dom.closestParent = (el, selector) ->
  ###
  Returns `el`'s first parent that matches `selector`, or null if none is found.
  TODO: Add polyfills here.
  ###
  el = el.parentNode
  while el
    return el if Dom.matches(el, selector)
    el = el.parentNode
  return null
