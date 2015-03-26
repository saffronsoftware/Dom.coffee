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
