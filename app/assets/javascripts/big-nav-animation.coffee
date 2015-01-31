jQuery ->
  navigation_text = $("nav .text")
  mq = window.matchMedia( "(min-width: 1301px)" )

  $('nav.main').mouseenter(->
    setTimeout (->
      navigation_text.fadeIn 'fast'
    ), 250
  ).mouseleave ->
    navigation_text.css {'display':'none'}


###
  #animation handled through css transition
  #-> that is way smoother!!!

  $('nav.main').hover ->
    if mq.matches
      $("nav.main").stop(true).animate
        'min-width': '300px'
      , 100, ->
        navigation_text.fadeIn 'fast'
  , ->
    if mq.matches
      navigation_text.fadeOut 'fast', ->
        $("nav.main").stop(true).animate
          'min-width': '80px'
###

  