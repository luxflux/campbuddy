jQuery ->
  navigation_text = $("nav .text")
  mq = window.matchMedia( "(min-width: 1251px)" )

  $("nav.main").hover (->
    if (mq.matches)
      navigation_text.css "display", "none"

      $("nav.main").stop(true).animate
        "min-width": "420px"
      , 100, ->
        navigation_text.fadeIn "fast"
        return
      return
  ), ->
    if (mq.matches)
      navigation_text.fadeOut("slow")
      $("nav.main").animate
        "min-width": "80px"
      , 500, ->
        navigation_text.fadeOut("slow")
        return
    return

