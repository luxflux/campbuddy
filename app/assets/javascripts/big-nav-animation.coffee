jQuery ->
  navigation_text = $("nav .text")

  $("nav.main").hover (->
    navigation_text.css "display", "none"

    $("nav.main").stop(true).animate
      "min-width": "420px"
    , 100, ->
      navigation_text.fadeIn "fast"
      return
    return
  ), ->
  
    navigation_text.fadeOut("slow")
    $("nav.main").animate
      "min-width": "80px"
    , 500, ->
      navigation_text.fadeOut("slow")
      return
    return

