
/*
Dom.coffee
https://github.com/vladh/Dom.coffee
 */
var Dom;

Dom = function(element) {
  return new Dom.prototype.init(element);
};

Dom.extend = Dom.prototype.extend = function() {
  var key, nrArgs, source, target, value;
  nrArgs = arguments.length;
  if (nrArgs === 1) {
    target = this;
    source = arguments[0];
  } else {
    target = arguments[0];
    source = arguments[1];
  }
  for (key in source) {
    value = source[key];
    target[key] = value;
  }
  return target;
};

Dom.prototype.init = function(element) {

  /*
  Takes either a DOM element or an array of DOM elements or NodeList a selector.
  @els is the list of elements for this instance.
  @elemData stores various data stored for elements (e.g. old display value).
   */
  if (Dom.isElement(element)) {
    this.els = [element];
  } else if (element.constructor === Array && element.every(Dom.isElement)) {
    this.els = element;
  } else if (element.constructor.name === 'NodeList' && [].slice.call(element).every(Dom.isElement)) {
    this.els = [].slice.call(element);
  } else if (Dom.isSelector(element)) {
    this.els = [].slice.apply(document.querySelectorAll(element));
  } else {
    throw Exception("Invalid argument");
  }
  return this;
};

Dom.prototype.init.prototype = Dom.prototype;

Dom.prototype.extend({
  map: function(fn) {
    var results;
    results = this.els.map(fn);
    if (results.length === 1) {
      return results[0];
    }
    return results;
  }
});

Dom.extend({
  elemData: {},
  getElemData: function(el, key) {
    if ((Dom.elemData[el] != null) && (Dom.elemData[el][key] != null)) {
      return Dom.elemData[el][key];
    } else {
      return null;
    }
  },
  setElemData: function(el, key, value) {
    var _base, _base1;
    (_base = Dom.elemData)[el] || (_base[el] = {});
    (_base1 = Dom.elemData[el])[key] || (_base1[key] = {});
    return Dom.elemData[el][key] = value;
  }
});

(function() {
  var isElement, isNode, isSelector;
  isNode = function(el) {
    if (typeof Node === 'object') {
      return el instanceof Node;
    } else {
      return el && typeof el === 'object' && typeof el.nodeType === 'number' && typeof el.nodeName === 'string';
    }
  };
  isElement = function(el) {
    if (typeof HTMLElement === 'object') {
      return el instanceof HTMLElement;
    } else {
      return el && typeof el === 'object' && el !== null && el.nodeType === 1 && typeof el.nodeName === 'string';
    }
  };
  isSelector = function(x) {

    /*
    This is a pretty naive check.
     */
    return typeof x === "string";
  };
  return Dom.extend({
    isNode: isNode,
    isElement: isElement,
    isSelector: isSelector
  });
})();

(function() {
  var append, appendTo, disable, empty, enable, getAttribute, getValue, html, remove, removeAttribute, setAttribute, setValue;
  empty = function(el) {
    return el.innerHTML = '';
  };
  html = function(el, content) {
    return el.innerHTML = content;
  };
  append = function(el, content) {
    if (typeof content === 'string') {
      el.innerHTML || (el.innerHTML = '');
      return el.innerHTML += content;
    } else if (Dom.isElement(content)) {
      return el.appendChild(content);
    } else {
      throw new Exception("Invalid argument");
    }
  };
  appendTo = function(el, parent) {
    return parent.appendChild(el);
  };
  getAttribute = function(el, name) {
    return el.getAttribute(name);
  };
  setAttribute = function(el, name, value) {
    return el.setAttribute(name, value);
  };
  removeAttribute = function(el, name) {
    return el.removeAttribute(name);
  };
  disable = function(el) {
    return setAttribute(el, 'disabled', 'disabled');
  };
  enable = function(el) {
    return removeAttribute(el, 'disabled');
  };
  remove = function(el) {
    return el.parentNode.removeChild(el);
  };
  setValue = function(el, value) {
    return el.value = value;
  };
  getValue = function(el) {
    return el.value;
  };
  return Dom.prototype.extend({
    empty: function() {
      this.map(empty);
      return this;
    },
    html: function(content) {
      this.map(function(el) {
        return html(el, content);
      });
      return this;
    },
    append: function(content) {
      this.map(function(el) {
        return append(el, content);
      });
      return this;
    },
    appendTo: function(parent) {
      this.map(function(el) {
        return appendTo(el, parent);
      });
      return this;
    },
    attr: function(name, value) {
      if (value != null) {
        this.map(function(el) {
          return setAttribute(el, name, value);
        });
        return this;
      } else {
        return this.map(function(el) {
          return getAttribute(el, name);
        });
      }
    },
    removeAttr: function(name) {
      this.map(function(el) {
        return removeAttribute(el, name);
      });
      return this;
    },
    disable: function() {
      this.map(disable);
      return this;
    },
    enable: function() {
      this.map(enable);
      return this;
    },
    remove: function() {
      this.map(remove);
      return this;
    },
    value: function(value) {
      if (value != null) {
        this.map(function(el) {
          return setValue(el, value);
        });
        return this;
      } else {
        return this.map(function(el) {
          return getValue(el);
        });
      }
    }
  });
})();

(function() {
  var addClass, containsClass, getStyle, hasClass, hide, isVisible, reNotWhitespace, removeClass, setStyle, show, spaceClass, toggle, toggleClass, trimClass;
  reNotWhitespace = /\S+/g;
  getStyle = function(el, name) {

    /*
    Falls back to using getComputedStyle if `el.style` doesn't have what we
    need. Perhaps consider optimising this.
     */
    if ((el.style[name] != null) && el.style[name].length > 0) {
      return el.style[name];
    } else {
      return getComputedStyle(el).getPropertyValue(name);
    }
  };
  setStyle = function(el, name, value) {
    return el.style[name] = value;
  };
  hide = function(el) {
    var display;
    if (!isVisible(el)) {
      return;
    }
    display = getStyle(el, 'display');
    if (display !== 'none') {
      Dom.setElemData(el, 'oldDisplay', display);
    }
    return setStyle(el, 'display', 'none');
  };
  show = function(el) {
    var newDisplay;
    if (isVisible(el)) {
      return;
    }
    newDisplay = Dom.getElemData(el, 'oldDisplay') || Dom.getDefaultDisplay(el.tagName);
    return setStyle(el, 'display', newDisplay);
  };
  isVisible = function(el) {
    return getStyle(el, 'display') !== 'none';
  };
  toggle = function(el) {
    if (isVisible(el)) {
      return hide(el);
    } else {
      return show(el);
    }
  };
  trimClass = function(cls) {
    return cls.replace(/[\t\r\n\f]/g, ' ');
  };
  spaceClass = function(cls) {
    if (cls) {
      return ' ' + trimClass(cls) + ' ';
    } else {
      return ' ';
    }
  };
  containsClass = function(parent, child) {
    return spaceClass(parent).indexOf(spaceClass(child)) !== -1;
  };
  hasClass = function(el, cls) {
    return containsClass(el.className, cls);
  };
  removeClass = function(el, strClasses) {
    var classes;
    classes = strClasses.match(reNotWhitespace) || [];
    if (classes.length === 0) {
      return;
    }
    return classes.map(function(cls) {
      var newClassName;
      if (!hasClass(el, cls)) {
        return;
      }
      newClassName = el.className;
      while (containsClass(newClassName, cls)) {
        newClassName = spaceClass(newClassName).replace(spaceClass(cls), ' ');
      }
      return el.className = newClassName.trim();
    });
  };
  addClass = function(el, strClasses) {
    var classes;
    classes = strClasses.match(reNotWhitespace) || [];
    if (classes.length === 0) {
      return;
    }
    return classes.map(function(cls) {
      var newClassName;
      if (hasClass(el, cls)) {
        return;
      }
      newClassName = spaceClass(el.className) + cls + ' ';
      return el.className = newClassName.trim();
    });
  };
  toggleClass = function(el, strClasses) {
    var classes;
    classes = strClasses.match(reNotWhitespace) || [];
    if (classes.length === 0) {
      return;
    }
    return classes.map(function(cls) {
      if (hasClass(el, cls)) {
        return removeClass(el, cls);
      } else {
        return addClass(el, cls);
      }
    });
  };
  return Dom.prototype.extend({
    style: function(name, value) {
      if (value != null) {
        this.map(function(el) {
          return setStyle(el, name, value);
        });
        return this;
      } else {
        return this.map(function(el) {
          return getStyle(el, name);
        });
      }
    },
    show: function() {
      this.map(show);
      return this;
    },
    hide: function() {
      this.map(hide);
      return this;
    },
    isVisible: function() {
      return this.map(isVisible);
    },
    toggle: function() {
      this.map(toggle);
      return this;
    },
    addClass: function(cls) {
      this.map(function(el) {
        return addClass(el, cls);
      });
      return this;
    },
    removeClass: function(cls) {
      this.map(function(el) {
        return removeClass(el, cls);
      });
      return this;
    },
    toggleClass: function(cls) {
      this.map(function(el) {
        return toggleClass(el, cls);
      });
      return this;
    },
    hasClass: function(cls) {
      return this.map(function(el) {
        return hasClass(el, cls);
      });
    }
  });
})();

(function() {
  var bind, loaded;
  bind = function(el, type, handler) {
    if (el.addEventListener) {
      return el.addEventListener(type, handler, false);
    } else if (el.attachEvent) {
      return el.attachEvent('on' + type, handler);
    } else {
      return el['on' + type] = handler;
    }
  };
  Dom.prototype.extend({
    bind: function(type, handler) {
      this.map(function(el) {
        return bind(el, type, handler);
      });
      return this;
    }
  });
  loaded = function(done) {
    return bind(document, 'DOMContentLoaded', done);
  };
  return Dom.extend({
    loaded: loaded
  });
})();

(function() {
  var closestParent, find, matches, parent;
  matches = (function() {

    /*
    From:
      https://github.com/desandro/matches-selector
      matchesSelector v1.0.3
      MIT license
     */
    var div, ensureHasParent, getMatchesMethod, match, matchChild, matchesMethod, matchesSelector, qsaFallback, supportsOrphans;
    ensureHasParent = function(elem) {
      var fragment;
      if (elem.parentNode) {
        return;
      }
      fragment = document.createDocumentFragment();
      return fragment.appendChild(elem);
    };
    qsaFallback = function(elem, selector) {
      var elems, i, _i, _ref;
      ensureHasParent(elem);
      elems = elem.parentNode.querySelectorAll(selector);
      for (i = _i = 0, _ref = elems.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        if (elems[i] === elem) {
          return true;
        }
      }
      return false;
    };
    matchChild = function(elem, selector) {
      ensureHasParent(elem);
      return match(elem, selector);
    };
    getMatchesMethod = function() {
      var i, method, prefix, prefixes, _i, _ref;
      if (Element.prototype.matches) {
        return 'matches';
      }
      if (Element.prototype.matchesSelector) {
        return 'matchesSelector';
      }
      prefixes = ['webkit', 'moz', 'ms', 'o'];
      for (i = _i = 0, _ref = prefixes.length; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        prefix = prefixes[i];
        method = prefix + 'MatchesSelector';
        if (Element.prototype[method]) {
          return method;
        }
      }
    };
    matchesMethod = getMatchesMethod();
    match = function(elem, selector) {
      return elem[matchesMethod](selector);
    };
    matchesSelector = null;
    if (matchesMethod) {
      div = document.createElement('div');
      supportsOrphans = match(div, 'div');
      matchesSelector = supportsOrphans ? match : matchChild;
    } else {
      matchesSelector = qsaFallback;
    }
    return matchesSelector;
  })();
  parent = function(el) {
    return Dom(el.parentNode);
  };
  closestParent = function(el, selector) {
    if (el.nodeType === 9) {
      return;
    }
    el = el.parentNode;
    while (el && el.nodeType !== 9) {
      if (el.nodeType === 1 && matches(el, selector)) {
        return Dom(el);
      }
      el = parent(el);
    }
    return null;
  };
  find = function(el, selector) {
    matches = el.querySelectorAll(selector);
    return Dom(matches);
  };
  return Dom.prototype.extend({
    matches: function(selector) {
      return this.map(function(el) {
        return matches(el, selector);
      });
    },
    parent: function() {
      return this.map(parent);
    },
    closestParent: function(selector) {
      return this.map(function(el) {
        return closestParent(el, selector);
      });
    },
    find: function(selector) {
      return this.map(function(el) {
        return find(el, selector);
      });
    }
  });
})();

(function() {
  var getDefaultDisplay;
  getDefaultDisplay = function(nodeName) {

    /*
    If we don't already know the default display, try making an element with
    that nodeName and getting its display.
     */
    var display, el;
    if (Dom.defaultDisplays[nodeName] != null) {
      return Dom.defaultDisplays[nodeName];
    }
    el = Dom(document.createElement(nodeName));
    el.appendTo(document.body);
    display = el.style('display');
    Dom.defaultDisplays[nodeName] = display;
    el.remove();
    display || (display = 'block');

    /*
    Apparently the createElement method may fail, and we would have to read
    the value from inside an iframe. Maybe account for this at some point.
     */
    return display;
  };
  return Dom.extend({
    defaultDisplays: {
      HTML: 'block',
      BODY: 'block'
    },
    getDefaultDisplay: getDefaultDisplay
  });
})();
