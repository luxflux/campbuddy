###
jQuery ->
  instagramAPI = "https://api.instagram.com/v1/tags/oywintercamp/media/recent?client_id=5f65f602eea445458472fa91247231de"
  $.getJSON( instagramAPI, ( data ) ->
    items = []
    $.each( data.data,( key, val ) ->
      items.push( "<img alt='" + val.caption.text + "' src='" + val.images.low_resolution + "'>")
    )
  )
###