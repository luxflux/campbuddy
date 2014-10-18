jQuery ->
  filters = $('nav.activity a')
  activities = $('.activities > div')


  filters.on 'click', (event) ->
    element = $(@)
    if element.hasClass('active')
      # actitivites.slideDown()
      filters.removeClass('active filtered-out')

    else
      filters.addClass('filtered-out')
      filters.removeClass('active')

      element.removeClass 'filtered-out'
      element.addClass 'active'

      filter = element.data('filter')
      activities.each (index) ->
        ele = $(@)
        if ele.hasClass(filter)
          ele.slideUp()
        else
          ele.slideDown()
