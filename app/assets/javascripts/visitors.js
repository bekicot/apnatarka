$(document).ready(function(){

  $('body').on('click', '.join-mess-btn' , function(){
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
		$.ajax({
      type: 'GET',
      url: '/chef_menus/save_customise_mess',
      data: {
        ids: ids
      }
    });
	});
});