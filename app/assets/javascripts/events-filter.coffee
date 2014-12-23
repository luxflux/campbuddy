jQuery ->
  filters = $('nav.events a')
  events = $('div.events .event-entry')


  filters.on 'click', (event) ->
    element = $(@)

    if element.hasClass('active')
      events.slideDown()
      filters.removeClass('active filtered-out')

    else
      filters.addClass('filtered-out')
      filters.removeClass('active')

      element.removeClass 'filtered-out'
      element.addClass 'active'

      filter = element.data('filter')

      events.each (index) ->
        ele = $(@)
        if ele.hasClass(filter)
          ele.slideDown()
        else
          ele.slideUp()

  events.on 'click', (event) ->
    element = $(@)

    window.location = element.find('a').first().attr('href')
