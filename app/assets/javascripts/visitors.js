$(document).ready(function(){

  $('body').on('click', '.join-mess-btn' , function(){
    $('#mess-availability').html('Already Joined Visit Dashboard Menu For more');
    $('#mess-availability').fadeIn('fast').delay(1000).fadeOut('slow')
  });

  $('body').on('click', '.custom-mess-btn' , function(){
    $('#custom-mess-availability').fadeIn('fast').delay(1000).fadeOut('slow')
  });

  $('body').on('click', '.custom-mess', function(){
  	var ids = []
  	var index = 0
  	$('input[type="checkbox"]:checked').each(function() {
   		ids[index] = ($(this).attr("id"));
   		index = index+1
  	});

    var mess_ids = ids.map(function(item) {
        return parseInt(item, 10);
      });
		$.ajax({
      type: 'GET',
      url: '/chef_menus/save_customise_mess',
      data: {
        ids: mess_ids
      }
    });
	});

  var readURL = function(input) {
      if (input.files && input.files[0]) {
          var reader = new FileReader();

          reader.onload = function (e) {
              $('.avatar').attr('src', e.target.result);
          }
  
          reader.readAsDataURL(input.files[0]);
      }
  }
  $(".file-upload").on('change', function(){
      readURL(this);
  });

  $('#customer_state').on('change', function(){
    var state = $(this).val();
    $.ajax({
      type: 'GET',
      url: '/dashboards/get_cities',
      dataType: 'json',
      data: {state: state}, 
      success: function(data){
        var $mySelect = $('#customer_city');
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