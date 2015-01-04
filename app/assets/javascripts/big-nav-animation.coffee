jQuery ->
  if window.navigator.standalone

    $("body").append($('<div>').attr("id","status-bar"))
    $('body').addClass "webapp"

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