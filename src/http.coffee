do ->
  post = (url, data, done, options) ->
    options ||= {}
    HTTPRequest.post(url, data, ((status, headers, content) ->
      content = JSON.parse(content) if options.json
      done(status, content, headers)
    ), options)

  postJSON = (url, data, done, options) ->
    options ||= {}
    options.json = true
    post(url, data, done, options)

  put = (url, data, done, options) ->
    options ||= {}
    HTTPRequest.put(url, data, ((status, headers, content) ->
      content = JSON.parse(content) if options.json
      done(status, content, headers)
    ), options)

  putJSON = (url, data, done, options) ->
    options ||= {}
    options.json = true
    put(url, data, done, options)

  get = (url, done, options) ->
    options ||= {}
    HTTPRequest.get(url, ((status, headers, content) ->
      content = JSON.parse(content) if options.json
      done(status, content, headers)
    ), options)

  getJSON = (url, done, options) ->
    options ||= {}
    options.json = true
    get(url, done, options)

  del = (url, done, options) ->
    options ||= {}
    HTTPRequest.del(url, ((status, headers, content) ->
      content = JSON.parse(content) if options.json
      done(status, content, headers)
    ), options)

  delJSON = (url, done, options) ->
    options ||= {}
    options.json = true
    del(url, done, options)

  Dom.extend {
    post, postJSON
    put, putJSON
    get, getJSON
    del, delJSON
  }
