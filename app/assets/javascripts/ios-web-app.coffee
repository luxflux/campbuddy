jQuery ->
  if window.navigator.standalone
    $("body").append($('<div>').attr("id","status-bar"))
    $('body').addClass "webapp"

    window.addEventListener "orientationchange", handleOrientation, false
    handleOrientation()

    #load auto ajax script to make the website behave more like a native app
    $.getScript "http://www.steve.org.uk/jquery/autoajax/jquery.autoajax.js", (data, textStatus, jqxhr) ->

      if jqxhr.status is 200
        $('body').attr("id", "body")
        $("nav.main.five a").each (index) ->
          href = $(this).attr("href")
          $(this).attr("href", href + "#body")

        #make transitions between loading the sites smooth
        $("nav.main.five a").on "click", ->
          $("body").append($('<div>').addClass("site-fader").attr("style", "display:none;"))
          $(".site-fader").fadeIn("fast")

        $("nav.main.five a").autoajax oncomplete: ->
          #alert "completed"
          $("body").append($('<div>').addClass("site-fader"))
          $(".site-fader").fadeOut("fast")


handleOrientation = ->
  if orientation is 0 or orientation is 180
    #portrait
    $("#status-bar").fadeIn "slow"
    $('body').addClass "webapp"
  else if orientation is -90 or orientation is 90
    #landscapeMode
    $("#status-bar").fadeOut "slow"
    $('body').removeClass "webapp"