# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('body').on 'click', 'a.item-modal', (e) ->
    $('.loader-area').show()
    setTimeout (->
      $('.loader-area').hide()
    ), 500
    return

  $('body').on 'click', '.nav-tabs li a', (e) ->
    $('.loader-area').show()
    setTimeout (->
      $('.loader-area').hide()
    ), 500
    return

