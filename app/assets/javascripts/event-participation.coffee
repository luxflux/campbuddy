jQuery ->
  $('.participation').on 'click', () ->
    element = $(@)

    element.children('.yes').each ->
      attendance_id = $(@).data('attendance-id')
      event_id = $(@).data('event-id')

      $.ajax
        url: '/attendances/' + attendance_id
        type: 'DELETE'

      .done (response)->
        Turbolinks.visit "/events/#{event_id}"

    element.children('.no').each ->
      event_id = $(@).data('event-id')

      $.ajax
        url: '/attendances'
        type: 'POST'
        data:
          attendance:
            event_id: event_id

      .done (response)->
        Turbolinks.visit "/events/#{event_id}"

