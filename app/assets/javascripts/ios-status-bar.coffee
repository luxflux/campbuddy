jQuery ->
  if window.navigator.standalone
    body = $('body')
    body.addClass "webapp"