
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
  Takes either a DOM element or a selector.
  @els is the list of elements for this instance.
  @elemData stores various data stored for elements (e.g. old display value).
   */
  if (Dom.isElement(element)) {
    this.els = [element];
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
  var append, disable, empty, enable, getAttribute, html, removeAttribute, setAttribute;
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
  getAttribute = function(el, attr) {
    return el.getAttribute(attr);
  };
  setAttribute = function(el, attr, value) {
    return el.setAttribute(attr, value);
  };
  removeAttribute = function(el, attr) {
    return el.removeAttribute(attr);
  };
  disable = function(el) {
    return setAttribute(el, 'disabled', 'disabled');
  };
  enable = function(el) {
    return removeAttribute(el, 'disabled');
  };
  return Dom.prototype.extend({
    empty: function() {
      return this.map(empty);
    },
    html: function(content) {
      return this.map(function(el) {
        return html(el, content);
      });
    },
    append: function(content) {
      return this.map(function(el) {
        return append(el, content);
      });
    },
    attr: function(attr, value) {
      if (value != null) {
        return this.map(function(el) {
          return setAttribute(el, attr, value);
        });
      } else {
        return this.map(function(el) {
          return getAttribute(el, attr);
        });
      }
    },
    disable: function() {
      return this.map(disable);
    },
    enable: function() {
      return this.map(enable);
    }
  });
})();

(function() {
  var getStyle, hide, isVisible, setStyle, show, toggle;
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
    Dom.setElemData(el, 'oldDisplay', getStyle(el, 'display'));
    return setStyle(el, 'display', 'none');
  };
  show = function(el) {
    return setStyle(el, 'display', Dom.getElemData(el, 'oldDisplay') || '');
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
  return Dom.prototype.extend({
    style: function(name, value) {
      if (value != null) {
        return this.map(function(el) {
          return getStyle(el, name);
        });
      } else {
        return this.map(function(el) {
          return setStyle(el, name, value);
        });
      }
    },
    show: function() {
      return this.map(show);
    },
    hide: function() {
      return this.map(hide);
    },
    isVisible: function() {
      return this.map(isVisible);
    },
    toggle: function() {
      return this.map(toggle);
    }
  });
})();

(function() {
  var bind;
  bind = function(el, type, handler) {
    if (el.addEventListener) {
      return el.addEventListener(type, handler, false);
    } else if (el.attachEvent) {
      return el.attachEvent('on' + type, handler);
    } else {
      return el['on' + type] = handler;
    }
  };
  return Dom.prototype.extend({
    bind: function(type, handler) {
      return this.map(function(el) {
        return bind(el, type, handler);
      });
    }
  });
})();

(function() {
  var closestParent, matches, parent;
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
    return el.parentNode;
  };
  closestParent = function(el, selector) {
    el = el.parentNode;
    while (el) {
      if (matches(el, selector)) {
        return el;
      }
      el = parent(el);
    }
    return null;
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
    }
  });
})();
