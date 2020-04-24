$(document).ready ->
  $('[data-toggle="tooltip"]').tooltip()
  $('.change-language').change ->
    $.ajax '/change_locale',
    type: 'POST',
    data: { locale: $(this).val() }
  t = (t) ->
    $(t).bind 'click', (t) ->
      t.preventDefault()
      $(this).parent().fadeOut()
      return
    return

  $('body').on 'click', '.about_status', ->
    $.ajax '/admin/abouts/'+ $(this).attr('data-id'),
    type: 'PUT'
    data: {value: $(this).val()}

  $('.dropdown-toggle').click ->
    `var t`
    t = $(this).parents('.button-dropdown').children('.dropdown-menu').is(':hidden')
    $('.button-dropdown .dropdown-menu').hide()
    $('.button-dropdown .dropdown-toggle').removeClass 'active'
    if t
      $(this).parents('.button-dropdown').children('.dropdown-menu').toggle().parents('.button-dropdown').children('.dropdown-toggle').addClass 'active'
    return
  $(document).bind 'click', (t) ->
    n = $(t.target)
    if !n.parents().hasClass('button-dropdown')
      $('.button-dropdown .dropdown-menu').hide()
    return
  $(document).bind 'click', (t) ->
    n = $(t.target)
    if !n.parents().hasClass('button-dropdown')
      $('.button-dropdown .dropdown-toggle').removeClass 'active'
    return
  return

  $('#fields').on('cocoon:after-insert', (e, inserted_item) ->
    debugger
    num = $('.fields').length
    inserted_item.find('.field-label').html('Field #'+num)
  )

