jQuery ->
  $('.partipicate').on 'click', () ->
    element = $(@)
    element.toggleClass('yes')
    if element.hasClass('yes')
      console.log 'send data that member wants to partipicate'
    else
      console.log 'send data that member no longer want to partipicate'
