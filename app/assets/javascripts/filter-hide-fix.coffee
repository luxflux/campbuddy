jQuery ->
  catalog = $('a[href$="/events/catalog"]')

  if catalog.hasClass('active')
    filters = $('nav.events a')
    forbidden = ["camp", "open", "radio"]

    filters.each (index) ->
      filter = $(this)
      filterColor = filter.data("filter")

      if !forbidden.indexOf(filter.text().toLowerCase())
        filter.css {"display": "none"}
        $(".event-entry." + filterColor).css {"display": "none"}

        console.log index + ': ' +filterColor+ " " + $(this).text()