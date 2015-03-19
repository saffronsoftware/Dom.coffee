class Dom
  ###
  Stores display data for elements (used for `show()` and `hide()`).
  ###
  @elemData = {}

  @hide: (el) ->
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

  @show: (el) ->
    ###
    Shows the given `el`, using its previous display value if we have it,
    or a default of "block".
    ###
    if Dom.elemData[el]? && Dom.elemData[el].oldDisplay?
      el.style.display = Dom.elemData[el].oldDisplay
    else
      el.style.display = 'block'

  @empty: (el) ->
    ###
    Empties `el`'s contents.
    ###
    el.innerHTML = ''

  @html: (el, html) ->
    ###
    Sets `el`'s HTML to `html`.
    ###
    el.innerHTML = html

  @append: (elParent, elChild) ->
    ###
    Appends `elChild` to `elParent`.
    ###
    elParent.appendChild(elChild)

  @appendHTML: (el, html) ->
    ###
    Appends `html` to `el`'s HTML.
    ###
    el.innerHTML ||= ''
    el.innerHTML += html

  @delete: (el) ->
    ###
    Deletes element `el`.
    ###
    el.parentNode.removeChild(el)

  @disable: (el) ->
    ###
    Sets `el`'s "disabled" attribute to "disabled".
    ###
    el.setAttribute('disabled', 'disabled')

  @enable: (el) ->
    ###
    Removes `el`'s "disabled" attribute".
    ###
    el.removeAttribute('disabled')

  @bind = (el, type, handler) ->
    ###
    Attach a handler of type `type` with function `handler` to element `el`.
    ###
    return if !el?
    if el.addEventListener
      el.addEventListener(type, handler, false)
    else if el.attachEvent
      el.attachEvent("on" + type, handler)
    else
      el['on' + type] = handler

  @isNode: (el) ->
    ###
    Returns true if `el` is a DOM Node.
    ###
    if typeof Node == 'object'
      el instanceof Node
    else
      el && typeof el == 'object' && typeof el.nodeType == 'number' &&
      typeof el.nodeName == 'string'

  @isElement: (el) ->
    ###
    Returns true if `el` is a DOM element.
    ###
    if typeof HTMLElement == 'object'
      el instanceof HTMLElement
    else
      el && typeof el == 'object' && el != null && el.nodeType == 1 &&
      typeof el.nodeName == 'string'
