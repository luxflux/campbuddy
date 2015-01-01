jQuery ->
  $('.partipicate').on 'click', () ->
    element = $(@)
    element.toggleClass('yes')
    if element.attr('data-attendance-id')
      $.ajax(
        url: "/attendances/" + element.data("attendance-id")
        type: "DELETE"

      ).done( (response)->
        console.log("/events/" + element.data("event-id"))
        window.location = "/events/" + element.data("event-id")
      )
    else
      $.ajax(
        url: "/attendances"
        type: "POST"
        data:
          attendance:
            user_id: $(@).data("user-id")
            event_id: $(@).data("event-id")

      ).done( (response)->
        console.log("/events/" + element.data("event-id"))
        window.location = "/events/" + element.data("event-id")
      )