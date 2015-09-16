jQuery ->
  $.ajax '/offline'
    .done (data) ->
      $(window).on 'offline', (event) ->
        Turbolinks.replace data

      $(window).on 'online', (event) ->
        setTimeout ->
          location.reload()
        , 4000
