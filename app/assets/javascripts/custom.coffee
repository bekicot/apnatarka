$ ->
  $('.change-language').click ->
    $.ajax '/change_locale',
      type: 'POST',
      data: { locale: $(this).attr("data-language") }

  $('.page-load').on 'click', (e) ->
    if e.button == 2
      $('.loader-area').show()
      return


  setTimeout (->
    $('.loader-area').hide()
    url_hash = window.location.hash
    if url_hash != ''
      $('a[href*="' + url_hash+ '"]').click()
      return
  ), 2000

  $(window).scroll ->
    $('#header').addClass 'fixed-header'
    if $(window).scrollTop() == 0
      $('#header').removeClass 'fixed-header'
    return

  $('body').on 'click', '.text-capitalize ', ->
    id = $(this).attr('data-id')
    $.ajax '/menu',
      type: 'GET'
      data: { id: id }

  $('body').on 'click', '.menu_category ', ->
    id = $(this).attr('data-id')
    $.ajax '/menu',
      type: 'GET',
      data: { id: id }



  $('.carousel').each ->
    if $(this).attr("data-lang") == 'true'
      $(this).carousel()
      carousel = $(this).data('bs.carousel')
      carousel.pause()
      $(this).find('> .carousel-inner > .item:not(:first-child)').each ->
        $(this).prependTo @parentNode
        return

      carousel.cycle = (e) ->
        if !e
          @paused = false
        if @interval
          clearInterval @interval
        @options.interval and !@paused and (@interval = setInterval($.proxy(@prev, this), @options.interval))
        this

      carousel.cycle()
      return




  $('#location .map-icons').on 'click', (event) ->
    tooltip = $('.location-caption .tooltip-txt')
    tooltip.find('p').html $(this).attr('title')
    tooltip.attr('data-id', $(this).data('id'))
    if $('#header').hasClass('fixed-header') || $('body').width() > 767
      navbar_height = 86
    else
      navbar_height = 0
    $('html, body').animate { scrollTop: ($("#map2040").offset().top - navbar_height) }, 1000

  $('#location .location-caption img').on 'click', (event) ->
    $('.loader-area').show()
    location_id = $(this).prev('.tooltip-txt').attr('data-id')
    $.ajax '/location/' + location_id,
    type: 'GET'

  $('#feedback_hear_through').on 'change', ->
    if $('#feedback_hear_through').val() == 'Other, please specify'
      $('#feedback_hear_through_other').removeAttr 'disabled'
    else
      $('#feedback_hear_through_other').attr('disabled', 'disabled').val ''
    return

  if gon.user_exist == true
    $('#delivery_details_modal').modal 'show'

  $('.d_mode').on 'click', () ->
    delivery_mode = $(this).data('attr')
    $.ajax '/delivery/set_delivery_mode',
      type: 'GET',
      dataType: 'script'
      data: { delivery_mode: delivery_mode }
