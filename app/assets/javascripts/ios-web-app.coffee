jQuery ->
  if window.navigator.standalone
    $("body").append($('<div>').attr("id","status-bar"))
    $('body').addClass "webapp"

    window.addEventListener "orientationchange", handleOrientation, false
    handleOrientation()

handleOrientation = ->
  if orientation is 0 or orientation is 180
    #portrait
    $("#status-bar").fadeIn "slow"
    $('body').addClass "webapp"
  else if orientation is -90 or orientation is 90
    #landscapeMode
    $("#status-bar").fadeOut "slow"
    $('body').removeClass "webapp"
