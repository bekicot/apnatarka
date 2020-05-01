$(document).ready(function(){
  $('#order_state').on('change', function(){
    var state = $(this).val();
    $.ajax({
      type: 'GET',
      url: '/delivery/get_cities',
      dataType: 'json',
      data: {state: state}, 
      success: function(data){
        var $mySelect = $('#order_city');
        jQuery.each(data, function(index, value) {
        var $option = $("<option/>", {
          value: value,
          text: value
        });
        $mySelect.append($option);
      });
      }
     });
  });

  total = 0
  $('.item-price').each(function(i) { 
    total = total + parseFloat($(this).text().split('-')[1]) 
  })
  if ($('.custom-total').length > 0 )
  {
   tax_percentage = parseFloat($('.tax-percentage').text().split(" ")[0]) / 100
   total_after_tax = total + (total * tax_percentage)
   $('.custom-total').text(total)
   $('.overall-total').text(total_after_tax)
  }

  $('body').on('keyup', '.quantity-item', function(){
    special_item_id = $('.special-item').val()
    quantity = $(this).val()
    $.ajax({
      type: 'GET',
      url: '/delivery/get_special_item',
      data: { special_item_id: special_item_id },
      success: function(data){
        total_price = data * parseFloat(quantity)
        $('.special-item-total-price').val(total_price)
      }
      });
  });

  if ($("#load_login_modals").length > 0) {
    $.ajax({
      type: 'GET',
      url: '/login_page'
    });
  }

  radio_button_checked();

  $('input[name="order[payment_method]"]:radio').on('click', function() {
    var value = $(this).parent('label').data('value');
    radio_button_checked(value);
  });

  $('body').on('change keyup', '.quantity-count', function(){
    chef_menu_item_id = $(this).attr('id').split('-').pop();
    quantity = $(this).val();
    if ((quantity != $(this).data("value")) && quantity != "" && quantity != 0){
      $.ajax({
        type: 'GET',
        url: '/delivery/update_quantity',
        data: {
          chef_menu_item_id: chef_menu_item_id,
          quantity: quantity
        }
      });
    }
  });

  $('body').on('change keyup', '.special-quantity-count', function(){
    item_id = $(this).attr('id').split('-').pop()
    quantity = $(this).val()
    if ((quantity != $(this).data("value")) && quantity != "" && quantity != 0){
      $.ajax({
        type: 'GET',
        url: '/delivery/update_special_item_quantity',
        data: {
          special_item_id: item_id,
          quantity: quantity
        }
      });
    }
  });

  $("body").on('blur', '.special-request', function(){
    var special_request = $(this).val();
    var item_id         = $(this).data("menu-id");
    if (special_request != "") {
      $.ajax({
        url: '/delivery/special_request',
        method: 'GET',
        dataType: 'json',
        data: {special_request: special_request, chef_menu_item_id: item_id}
      })
    }
  });

  $('[data-toggle="tooltip"]').tooltip();

  if ($('#billing-details').length > 0) {
    var checkbox = document.getElementById('check');
    if(!checkbox.checked) {
      $('.position').css("display", "none");
    }
    checkbox.onchange = function() {
      if(this.checked) {
        $('.position').css("display", "none");
        $('#order_long').val(gon.longitude);
        $('#order_lat').val(gon.latitude);
        $('#current_location').html(gon.loc);
      } else {
        $('.position').css("display", "none");
        $('#order_long').val('');
        $('#order_lat').val('');
        $('#current_location').html('');
      }
    };
  }

  $('body').on('focusout', '#check-signup-email', function(){
    var email = $(this).val();
    if (email != "") {
      $.ajax({
        url: '/checkemail',
        method: 'GET',
        data: {email: email}
      })
    } else {
      $('#email-availability').html('');
    }
  });

  $('body').on('click', '.inc-quan', function(){
    item_id = $(this).attr('id').split('-').pop();
    quantity = $(this).data("value")
    if (quantity != "" && quantity != 0){
      $.ajax({
        type: 'GET',
        url: '/delivery/update_quantity',
        data: {
          chef_menu_item_id: item_id,
          quantity: quantity+1
        }
      });
    }
  });

  $('body').on('click', '.special-item-quantity', function(){
    item_id = $(this).attr('id').split('-').pop()
    quantity = $(this).data('value')
    if (quantity != "" && quantity != 0){
      $.ajax({
        type: 'GET',
        url: '/delivery/update_special_item_quantity',
        data: {
          special_item_id: item_id,
          quantity: quantity+1
        }
      });
    }
  });
});

$('body').on('click', '#delivery_later_btn', function(){
  var delivery_time = $("#pick_time").val();
  $.ajax('/address/set_delivery_time', {
    type: 'POST',
    data: {
      delivery_time: delivery_time
    }
  });
});

$('body').on('click', '#new_address_btn', function(){
  var delivery_mode = $("input[name='d_mode']:checked").data('attr');
  var pick_time = $("#pick_time").val();
  var location_id = $('.change-location').find(":selected").val();
  return $.ajax('/delivery/save_delivery_mode', {
    type: 'GET',
    data: {
      delivery_mode: delivery_mode,
      location_id: location_id,
      pick_time: pick_time
    }
  });
});

function close_modal(){
  $('#item-chefs-modal').modal('hide');
  $('#add-more-items-modal').modal('show');
}

function radio_button_checked(value) {
  if ( value == undefined ) {
    var value = $("#place_order").data('disable-with');
  }
  $("#place_order").val(value);
}

function login_signup_modals() {
  $('body').on("click", "#show-sign-up-modal", function(){
    $('#sign-in-modal').modal('hide');
    $('#sign-up-modal').modal({backdrop: 'static', keyboard: false});
  });

  $('body').on("click", "#show-sign-in-modal", function(){
    $('#sign-in-modal').modal({backdrop: 'static', keyboard: false});
    $('#sign-up-modal').modal('hide');
  });

  $("body").on('change', '#user_address', function(){
    var address = document.getElementById('user_address').value;
    getLatitudeLongitude(showResult, address)
  });
}

function geocodePosition(pos) {
  geocoder.geocode({
    latLng: pos
  }, function(responses) {
    if (responses && responses.length > 0) {
      updateMarkerAddress(responses[0].formatted_address);
    } else {
      updateMarkerAddress('Cannot determine address at this location.');
    }
  });
}

function updateMarkerAddress(str) {
  document.getElementById('user_address').value = str;
}

function map_initialize(lat, lng) {
  var latLng = new google.maps.LatLng(lat, lng);
  var map = new google.maps.Map(document.getElementById('mapCanvas'), {
    zoom: 17,
    center: latLng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
  var marker = new google.maps.Marker({
    position: latLng,
    title: 'Point A',
    map: map,
    draggable: true
  });

  // Update current position info.
  geocodePosition(latLng);

  // Add dragging event listeners.
  google.maps.event.addListener(marker, 'dragstart', function() {
    updateMarkerAddress('Dragging...');
  });

  google.maps.event.addListener(marker, 'dragend', function() {
    geocodePosition(marker.getPosition());
  });

  google.maps.event.addListener(map, 'click', function(e) {
    geocodePosition(marker.getPosition());
    marker.setPosition(e.latLng);
  });

  google.maps.event.addDomListener(window, 'load', map_initialize);

}

function showResult(result) {
  var lat = result.geometry.location.lat();
  var lng = result.geometry.location.lng();
  map_initialize(lat, lng);
}

function getLatitudeLongitude(callback, address) {
  address = address || 'Ferrol, Galicia, Spain';
  geocoder = new google.maps.Geocoder();
  if (geocoder) {
    geocoder.geocode({
      'address': address
    }, function (results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        callback(results[0]);
      }
    });
  }
}
