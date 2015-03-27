do ->
  matches = do ->
    ###
    From:
      https://github.com/desandro/matches-selector
      matchesSelector v1.0.3
      MIT license
    ###

    ensureHasParent = (elem) ->
      return if elem.parentNode
      fragment = document.createDocumentFragment()
      fragment.appendChild(elem)

    qsaFallback = (elem, selector) ->
      ensureHasParent(elem)
      elems = elem.parentNode.querySelectorAll(selector)
      for i in [0...elems.length]
        return true if elems[i] == elem
      return false

    matchChild = (elem, selector) ->
      ensureHasParent(elem)
      return match(elem, selector)

    getMatchesMethod = ->
      if Element.prototype.matches
        return 'matches'
      if Element.prototype.matchesSelector
        return 'matchesSelector'
      prefixes = ['webkit', 'moz', 'ms', 'o']
      for i in [0...prefixes.length]
        prefix = prefixes[i]
        method = prefix + 'MatchesSelector'
        if Element.prototype[method]
          return method

    matchesMethod = getMatchesMethod()
    match = (elem, selector) -> elem[matchesMethod](selector)
    matchesSelector = null

    if matchesMethod
      # IE9 supports matchesSelector, but doesn't work on orphaned elems
      # check for that
      div = document.createElement('div')
      supportsOrphans = match(div, 'div')
      matchesSelector = if supportsOrphans then match else matchChild
    else
      matchesSelector = qsaFallback

    return matchesSelector

  parent = (el) -> el.parentNode

  closestParent = (el, selector) ->
    el = el.parentNode
    while el
      return el if matches(el, selector)
      el = parent(el)
    return null

  Dom.prototype.extend {
    matches: (selector) ->
      @map (el) -> matches(el, selector)
    parent: -> @map(parent)
    closestParent: (selector) ->
      @map (el) -> closestParent(el, selector)
  }
