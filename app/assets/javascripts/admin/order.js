$(document).ready(function(){
  $('.order-category').on('change', function(){
    var category = $(this).val();
    $.ajax({
      type: 'GET',
      url: '/admin/orders/order_items',
      dataType: 'json',
      data: {category: category}, 
      success: function(data){
        var $mySelect = $('#menu_item');
        jQuery.each(data, function(index, value) {
          var $option = $("<option/>", {
          value: value[0],
          text: value[1]
        });
        $mySelect.append($option);
      });
      }
     });
  }); 

  $('.order-menu-item').on('change', function(){
    var menu_item = $(this).val().split(',')[0]
    $.ajax({
      type: 'GET',
      url: '/admin/orders/order_chefs',
      dataType: 'json',
      data: {menu_item: menu_item}, 
      success: function(data){
        var $mySelect = $('#chef');
        jQuery.each(data, function(index, value) {
        var $option = $("<option/>", {
          value: value[0],
          text: value[1]
        });
        $mySelect.append($option);
      });
      }
     });
  }); 

  $('body').on('focusout', '#check-phone', function(){
    var phone = $(this).val();
    if (phone != "") {
      $.ajax({
        url: '/admin/orders/checkemail',
        method: 'GET',
        data: {phone: phone}
      })
    } else {
      $('#email-availability').html('');
    }
  });

  $('.collapsible').on('click', function(){
    var coll = document.getElementsByClassName("collapsible");
    var i;

    for (i = 0; i < coll.length; i++) {
      coll[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var content = this.nextElementSibling;
        if (content.style.display === "block") {
          content.style.display = "none";
        } else {
          content.style.display = "block";
        }
      });
    }
  });

  $('.country-states').on('change', function(){
    var state = $(this).val();
    $.ajax({
      type: 'GET',
      url: '/admin/orders/check_cities',
      dataType: 'json',
      data: {state: state}, 
      success: function(data){
        var $mySelect = $('.cities');
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

});
