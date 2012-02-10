jQuery ->
  ###
    Weather API setup
  ###
  # This will be the jQuery data structure for holding the weather related stuff
  jQuery.Weather = {}
  # To keep track of where we are in the returned results if the user wnats a different city
  jQuery.Weather.result_index = 0
  jQuery.Weather.location = ""
  jQuery.Weather.find_sunshine = ->
    # If the results aren't yet loaded or the location in the input field is different, then load up new results
    if typeof(jQuery.Weather.results) == 'undefined' || jQuery.Weather.location != jQuery(".search-input>input").val()
      jQuery.getJSON "/weather/nearest_sunshine.json", location: jQuery(".search-input>input").val(), (data) ->
        jQuery.Weather.result_index = -1
        jQuery.Weather.location = jQuery(".search-input>input").val()
        jQuery.Weather.results = data
        # Call this function again now that the data is loaded
        jQuery.Weather.find_sunshine()
      return true
  
    # The data will be loaded at this point, load it into the spans and show the results
    jQuery.Weather.result_index++
    if jQuery.Weather.result_index >= jQuery.Weather.results.length
      jQuery.Weather.result_index = 0
    jQuery("span.distance").text Math.round(jQuery.Weather.results[jQuery.Weather.result_index].distance)
    jQuery("span.found-city").text jQuery.Weather.results[jQuery.Weather.result_index].city
    jQuery("div.results").show()

  ###
    Initial Style setup
  ###
  # These next few lines will deal with copying the green hill over and over again so that it covers the screen
  doc_width = jQuery(document).width() * 1.05
  left_pos = -20
  while (left_pos + 300) < doc_width
    left_pos += 150 * Math.random() + 100
    jQuery(".hill").first().clone().css("left", left_pos).appendTo ".non-shadow-hills"
  jQuery(".non-shadow-hills>.hill").clone().appendTo ".shadow-hills"
  
  ###
    Sunshine Search setup
  ###
  # The mouseup and mousedown events will change the CSS so that it looks like the button is being depressed
  jQuery(".search-button").mouseup ->
    jQuery(this).css "background-color", "#222"
    jQuery(this).css "border-color", "#fff"
    jQuery(this).css "outline-color", "#222"
    jQuery(this).css "color", "#fff"
  jQuery(".search-button").mousedown ->
    jQuery(this).css "background-color", "#fff"
    jQuery(this).css "border-color", "#222"
    jQuery(this).css "outline-color", "#fff"
    jQuery(this).css "color", "#222"

  # Create the enter key press catch for the input box to submit the search
  jQuery(".search-input>input").keydown (e) ->
    if e.keyCode == 13
      jQuery.Weather.find_sunshine()
      jQuery(this).blur()
  # Submit the search if the button is pressed.  Or if the search already took place, check for the next furthest away
  jQuery(".search-button,p.try-again>a").click (e) ->
    e.preventDefault()
    if (jQuery(".search-input>input").val().length > 0)
      jQuery.Weather.find_sunshine()

  ###
    Footer link setup
  ###
  jQuery('a#about-link,#close-about-box').click (e) ->
    e.preventDefault()
    jQuery('.about-box').toggle()
    jQuery('.main-content').toggle()