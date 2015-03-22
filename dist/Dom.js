var Dom;

Dom = {};


/*
Stores display data for elements (used for `show()` and `hide()`).
 */

Dom.elemData = {};

Dom.hide = function(el) {

  /*
  Hides the given `el`, storing its display value in order to be able to
  restore it when `show()`ing the element.
   */
  var _base;
  (_base = Dom.elemData)[el] || (_base[el] = {});
  if (!el.style.display || el.style.display === 'none') {
    Dom.elemData[el].oldDisplay = 'block';
  } else {
    Dom.elemData[el].oldDisplay = el.style.display;
  }
  return el.style.display = 'none';
};

Dom.show = function(el) {

  /*
  Shows the given `el`, using its previous display value if we have it,
  or a default of "block".
   */
  if ((Dom.elemData[el] != null) && (Dom.elemData[el].oldDisplay != null)) {
    return el.style.display = Dom.elemData[el].oldDisplay;
  } else {
    return el.style.display = 'block';
  }
};

Dom.empty = function(el) {

  /*
  Empties `el`'s contents.
   */
  return el.innerHTML = '';
};

Dom.html = function(el, html) {

  /*
  Sets `el`'s HTML to `html`.
   */
  return el.innerHTML = html;
};

Dom.append = function(el, child) {

  /*
  Appends `elChild` to `elParent`.
   */
  return el.appendChild(child);
};

Dom.appendHTML = function(el, html) {

  /*
  Appends `html` to `el`'s HTML.
   */
  el.innerHTML || (el.innerHTML = '');
  return el.innerHTML += html;
};

Dom["delete"] = function(el) {

  /*
  Deletes element `el`.
   */
  return el.parentNode.removeChild(el);
};

Dom.disable = function(el) {

  /*
  Sets `el`'s "disabled" attribute to "disabled".
   */
  return el.setAttribute('disabled', 'disabled');
};

Dom.enable = function(el) {

  /*
  Removes `el`'s "disabled" attribute".
   */
  return el.removeAttribute('disabled');
};

Dom.bind = function(el, type, handler) {

  /*
  Attach a handler of type `type` with function `handler` to element `el`.
   */
  if (el == null) {
    return;
  }
  if (el.addEventListener) {
    return el.addEventListener(type, handler, false);
  } else if (el.attachEvent) {
    return el.attachEvent('on' + type, handler);
  } else {
    return el['on' + type] = handler;
  }
};

Dom.bindAll = function(els, type, handler) {

  /*
  Bind for each element in `els`.
   */
  return [].forEach.call(els, function(el) {
    return Dom.bind(el, type, handler);
  });
};

Dom.matches = function(el, selector) {

  /*
  Returns true if `el` matches `selector`.
  Adapted from https://developer.mozilla.org/en-US/docs/Web/API/Element/matches
   */
  var i, matches;
  matches = (el.parentNode || el.document || el.ownerDocument).querySelectorAll(selector);
  i = 0;
  while (matches[i] && matches[i] !== el) {
    i++;
  }
  return matches[i] != null;
};

Dom.closestParent = function(el, selector) {

  /*
  Returns `el`'s first parent that matches `selector`, or null if none is found.
  TODO: Add polyfills here.
   */
  while (el) {
    el = el.parentNode;
    if (Dom.matches(el, selector)) {
      return el;
    }
  }
  return null;
};

Dom.isNode = function(el) {

  /*
  Returns true if `el` is a DOM Node.
   */
  if (typeof Node === 'object') {
    return el instanceof Node;
  } else {
    return el && typeof el === 'object' && typeof el.nodeType === 'number' && typeof el.nodeName === 'string';
  }
};

Dom.isElement = function(el) {

  /*
  Returns true if `el` is a DOM element.
   */
  if (typeof HTMLElement === 'object') {
    return el instanceof HTMLElement;
  } else {
    return el && typeof el === 'object' && el !== null && el.nodeType === 1 && typeof el.nodeName === 'string';
  }
};
