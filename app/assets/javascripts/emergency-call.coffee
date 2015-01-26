jQuery ->
  $('#trigger-emergency').click ->
    $('.emergency-box').fadeIn "fast"

  $('.emergency-box .prompt .icon').click ->
    $('.emergency-box').fadeOut "fast"