jQuery ->
  $('.instagram-feed').each () ->
    element = $(@)
    tag = element.data('instagram-tag')
    client_id = element.data('instagram-client-id')

    instagramAPI = "https://api.instagram.com/v1/tags/#{tag}/media/recent?client_id=#{client_id}"
    $.ajax
      url: instagramAPI
      jsonp: "callback"
      dataType: "jsonp"
      success: (response) ->
        $.each response.data, (key, value) ->
          element.append "<a href='#{value.link}' target='_blank'><img src='#{value.images.low_resolution.url}'></a>"
