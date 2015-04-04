# Dom.coffee

A lightweight DOM manipulation library written in Coffeescript.

## To-do
* Add chaining
* Make more methods (e.g. `.parent()`) return Dom.coffee elements as opposed to
regular DOM elements.

## API

### CSS

#### `.style(name[, value])`
##### Arguments
* `name`: The name of the style property
* `value`: The optional value to set the property to
##### Returns
The value of the element's style property `name` if `value` is not given.
If `value` is not set, returns the value of the element's `name` style
property. If `value` is set, set this property to the given value.
##### Example
```coffee
Dom('.thing').style('display')
>> none
Dom('.thing').style('display', 'block')
>> block
```

#### `.show()`
Shows the element by setting its display to a non-"none" value. This value
is determined by looking it up in the cache in case `.hide()` put it there,
or using a value determined by the node type otherwise.

#### `.hide()`
Hides an element by settings its display to "none". Its previous display
is cached so that it may be restored when showing the element.

#### `.isVisible()`
##### Returns
Whether or not the element is visible. This is determined by checking if its
display is "none".

#### `.toggle()`
Toggles the element's visibility. If it is visible calls `.hide()`, otherwise
calls `.show()`.

#### `.addClass(cls)`
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
##### Arguments
* `cls`: A class name or whitespace-separated class list
Removes the class(es) `cls` from the element, unless the element does not
have one of them, in which case it does not remove that class. This removes
all occurences of a class if it occurs multiple times.
##### Example
```coffee
Dom('.hi.there').addClass('here')
# Element will now have class .there
```

#### `.toggleClass(cls)`
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

### HTML
#### `.empty()`
Sets element's innerHTML to an empty string, removing its contents.

#### `.html(content)`
##### Arguments
* `content`: An HTML string
Sets element's innerHTML string to `content`.

#### `.append(content)`
##### Arguments
* `content`: Either (1) an HTML string or (2) a DOM element
Appends the given HTML string or DOM element to the end of the element.
##### Example
```coffee
foo = Dom('.foo').append('<p>Hi.</p>')
Dom('.bar').append(document.createElement('p'))
```

#### `.appendTo(parent)`
##### Arguments
* `parent`: A DOM element (not a Dom.coffee element)
Appends the element to the given `parent`.

#### `.attr(name[, value])`
##### Arguments
* `name`: The name of the attribute
* `value`: The optional value to set the attribute to
##### Returns
The value for attribute `name` if `value` is not given.
If `value` is not set, returns the value of the element's `name` attribute.
If `value` is set, set this attribute to the given value.
##### Example
```coffee
Dom('.thing').attr('data-id')
>> 20
Dom('.thing').attr('data-id', '23')
>> 23
```

#### `.removeAttr(attr)
##### Arguments
* `name`: The name of the attribute
Removes the element's `name` attribute.

#### `.disable()`
Sets the element's "disabled" attribute to "disabled".

#### `.enable()`
Remove the element's "disabled" attribute.

#### `.remove()`
Removes the element.

#### `.value([value])`
##### Arguments
* `value`: The optional value to set the value to
##### Returns
The element's current value if `value` is not given.
If `value` is present, sets the element's value to that value. Otherwise,
returns the element's current value.

### Events
#### `.bind(type, handler)`
##### Arguments
* `type`: The event type to bind (e.g. "click", "keyup")
* `handler`: A function to be run when the event fires
Binds event `type` on the element to function `handler`.
##### Example
```coffee
Dom('.btn').bind 'click', ->
  console.log('Hi!')
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
The element's parent DOM element (not Dom.coffee element).

#### `.closestParent(selector)`
##### Arguments
* `selector`: A selector string
##### Returns
The closest parent of this element that matches `selector`. A DOM element
(not Dom.coffee element) is returned.

#### `.find(selector)`
##### Arguments
* `selector`: A selector string
##### Returns
This element's children that match `selector`. DOM elements (not Dom.coffee
elements) are returned.

### Checks

#### `Dom.isNode(el)`
##### Arguments
* `el`: A DOM element (not a Dom.coffee element)
##### Returns
Whether or not `el` is a DOM node.

#### `Dom.isElement(el)`
##### Arguments
* `el`: A DOM element (not a Dom.coffee element)
##### Returns
Whether or not `el` is a DOM element.

## Credits

Build at [Phyramid](http://www.phyramid.com) for internal use.

Structure inspired by jQuery.

`matches()` and relevant tests from [desandro/matches-selector](https://github.com/desandro/matches-selector).
