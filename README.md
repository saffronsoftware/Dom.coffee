# Dom.coffee

A lightweight DOM manipulation library written in Coffeescript.

*n.b.:* `Dom` in sentence case refers to this library, while `DOM` refers to
the browser's DOM.

## API

### Creating a Dom instance

The Dom constructor takes one of:

* a DOM element
* an array of DOM elements
* a NodeList
* a selector
* `document`
* `window`

##### Example
```coffee
Dom(document.getElementById('header'))
Dom(document.createElement('div'))
Dom(document.querySelector('.duck'))
Dom('#homer-simpson')
Dom('.hat .cat')
Dom(document)
Dom(window)
```

### CSS

#### `.style(name[, value])`
##### Arguments
* `name`: The name of the style property
* `value`: The optional value to set the property to

##### Returns
The value of the element's style property `name` if `value` is not given.
If `value` is given, returns a Dom instance.

If `value` is not set, returns the value of the element's `name` style
property. If `value` is set, set this property to the given value.

##### Example
```coffee
Dom('.thing').style('display')
>> none
Dom('.thing').style('display', 'block')
>> block
```

#### `.width()`
##### Returns
The width of the given element. Similar to `.style('width')`, but returns
a number instead of a pixel string. May return NaN for values such as
`auto`.

Alternatively, this method may be used to find the size of the `window`.

#### `.height()`
##### Returns
The height of the given element. Similar to `.style('height')`, but returns
a number instead of a pixel string. May return NaN for values such as
`auto`.

Alternatively, this method may be used to find the size of the `window`.

#### `.show()`
##### Returns
A Dom instance.

Shows the element by setting its display to a non-"none" value. This value
is determined by looking it up in the cache in case `.hide()` put it there,
or using a value determined by the node type otherwise.

#### `.hide()`
##### Returns
A Dom instance.

Hides an element by settings its display to "none". Its previous display
is cached so that it may be restored when showing the element.

#### `.isVisible()`
##### Returns
Whether or not the element is visible. This is determined by checking if its
display is "none".

#### `.toggle()`
##### Returns
A Dom instance.

Toggles the element's visibility. If it is visible calls `.hide()`, otherwise
calls `.show()`.

#### `.addClass(cls)`
##### Returns
A Dom instance.

##### Arguments
* `cls`: A class name or whitespace-separated class list

Adds the class(es) `cls` to the element, unless the element already has
one of these classes, in which case that class is not added.

##### Example
```coffee
Dom('.foo').addClass('hi there')
# Element will now have classes .foo, .hi and .there
```

#### `.removeClass(cls)`
##### Returns
A Dom instance.

##### Arguments
* `cls`: A class name or whitespace-separated class list

Removes the class(es) `cls` from the element, unless the element does not
have one of them, in which case it does not remove that class. This removes
all occurences of a class if it occurs multiple times.

##### Example
```coffee
Dom('.hi.there').removeClass('hi')
# Element will now have class .there
```

#### `.toggleClass(cls)`
##### Returns
A Dom instance.

##### Arguments
* `cls`: A class name or whitespace-separated class list

For the class(es) `cls`, calls `.removeClass(cls)` if the element already
has that class and `.addClass(cls)` otherwise.

```coffee
Dom('.no').toggleClass('no yes')
# Element will now have class .yes
```

#### `.hasClass(cls)`
##### Arguments
* `cls`: A class name or whitespace-separated class list

##### Returns
For the class string `cls`, returns whether or not the element has that
class string. If `cls` has multiple classes, this means that the element must
have all of them for this method to return true.

#### `Dom.scrollTop()`
##### Returns
The current vertical scroll position.

### HTML
#### `.empty()`
##### Returns
A Dom instance.

Sets element's innerHTML to an empty string, removing its contents.

#### `.html(content)`
##### Returns
A Dom instance.

##### Arguments
* `content`: An HTML string

Sets element's innerHTML string to `content`.

#### `.append(content)`
##### Returns
A Dom instance.

##### Arguments
* `content`: Either (1) an HTML string, (2) a DOM element or (3) a Dom instance

Appends the given HTML string or DOM element to the end of the element.

##### Example
```coffee
foo = Dom('.foo').append('<p>Hi.</p>')
Dom('.bar').append(document.createElement('p'))
Dom('.bar').append(Dom('.baz'))
```

#### `.appendTo(parent)`
##### Returns
A Dom instance.

##### Arguments
* `parent`: Either (1) a DOM element or (2) a Dom instance

Appends the element to the given `parent`.

#### `.clone(deep)`
##### Returns
A Dom instance.

##### Arguments
* `deep`: `true` if the children of the node should also be cloned, or `false`
          to clone only the specified node

Clones a node, just like [Javascript's .cloneNode()](https://developer.mozilla.org/en-US/docs/Web/API/Node/cloneNode).

#### `.attr(name[, value])`
##### Arguments
* `name`: The name of the attribute
* `value`: The optional value to set the attribute to

##### Returns
The value for attribute `name` if `value` is not given. If `value` is given,
returns a Dom instance.

If `value` is not set, returns the value of the element's `name` attribute.
If `value` is set, set this attribute to the given value.

##### Example
```coffee
Dom('.thing').attr('data-id')
>> 20
Dom('.thing').attr('data-id', '23')
>> 23
```

#### `.removeAttr(attr)`
##### Returns
A Dom instance.

##### Arguments
* `name`: The name of the attribute

Removes the element's `name` attribute.

#### `.disable()`
##### Returns
A Dom instance.

Sets the element's "disabled" attribute to "disabled".

#### `.enable()`
##### Returns
A Dom instance.

Remove the element's "disabled" attribute.

#### `.remove()`
##### Returns
A Dom instance.

Removes the element.

#### `.checked()`
##### Returns
`true` or `false`.

Returns whether or not an input is checked.

#### `.value([value])`
##### Arguments
* `value`: The optional value to set the value to

##### Returns
The element's current value if `value` is not given. If `value` is given,
returns a Dom instance.

If `value` is present, sets the element's value to that value. Otherwise,
returns the element's current value.

### Events
#### `.bind(type, handler)`
##### Returns
A Dom instance.

##### Arguments
* `type`: The event type to bind (e.g. "click", "keyup")
* `handler`: A function to be run when the event fires

Binds event `type` on the element to function `handler`.

##### Example
```coffee
Dom('.btn').bind 'click', ->
  console.log('Hi!')

Dom(window).bind 'resize', ->
  console.log('Woo!')
```
#### `Dom.loaded(done)`
##### Arguments
* `done`: Function to be called when document is loaded

Runs a function when the document is loaded, more precisely when
DOMContentLoaded is fired.

### Traversal
#### `.matches(selector)`
##### Arguments
* `selector`: A selector string

##### Returns
Whether or not the element matches the given selector.

#### `.parent()`
##### Returns
A Dom instance with the element's parent.

#### `.closestParent(selector)`
##### Arguments
* `selector`: A selector string

##### Returns
A Dom instance with the closest parent of this element that matches `selector`,
or null if none is found.

#### `.thisOrClosestParent(selector)`
##### Arguments
* `selector`: A selector string

##### Returns
Like `.closestParent()`, but first checks if the current element matches, and
returns it if it does.

#### `.find(selector)`
##### Arguments
* `selector`: A selector string

##### Returns
A new Dom instance with the element's children that match `selector`. If the
current instance has more than one element, this function will return
a flat array with the found children for all elements.

### HTTP

#### `Dom.post(url, data, done, options)`
##### Arguments
* `url` [String]
* `data` [Object]
* `done` [Function (status [Number], content [Object], headers [Object])]
* `options` [Object]
  * `json` [Boolean]: Whether or not to parse the response as JSON

Makes a POST request.

#### `Dom.postJSON(url, data, done, options)`
Same as `.post()`, but adds `{json: true}` to `options`.

#### `Dom.put(url, data, done, options)`
##### Arguments
* `url` [String]
* `data` [Object]
* `done` [Function (status [Number], content [Object], headers [Object])]
* `options` [Object]
  * `json` [Boolean]: Whether or not to parse the response as JSON

Makes a PUT request.

#### `Dom.putJSON(url, data, done, options)`
Same as `.put()`, but adds `{json: true}` to `options`.

#### `Dom.get(url, done, options)`
##### Arguments
* `url` [String]
* `done` [Function (status [Number], content [Object], headers [Object])]
* `options` [Object]
  * `json` [Boolean]: Whether or not to parse the response as JSON

Makes a GET request.

#### `Dom.getJSON(url, data, done, options)`
Same as `.get()`, but adds `{json: true}` to `options`.

#### `Dom.del(url, done, options)`
##### Arguments
* `url` [String]
* `done` [Function (status [Number], content [Object], headers [Object])]
* `options` [Object]
  * `json` [Boolean]: Whether or not to parse the response as JSON

Makes a DELETE request.

#### `Dom.delJSON(url, done, options)`
Same as `.del()`, but adds `{json: true}` to `options`.

### Checks

#### `Dom.isNode(el)`
##### Arguments
* `el`: A DOM element (not a Dom.coffee instance)

##### Returns
Whether or not `el` is a DOM node.

#### `Dom.isElement(el)`
##### Arguments
* `el`: A DOM element (not a Dom.coffee instance)

##### Returns
Whether or not `el` is a DOM element.

## Credits

Built at [Phyramid](http://www.phyramid.com) for internal use.

[HTTPRequest](https://www.npmjs.com/package/HTTPRequest) used for HTTP requests.

Structure inspired by jQuery.

`matches()` and relevant tests from [desandro/matches-selector](https://github.com/desandro/matches-selector).
