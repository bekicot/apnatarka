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

  $('body').on('click', '.add_to_cart_item', function(){
    chef_menu_item_id = $(this).attr("id").split("_")[3]
    $.ajax({
      type: 'GET',
      url: '/menu/:menu_id/item_chefs/check_chef',
      data: {chef_menu_item: chef_menu_item_id }
    });
  });

  var secondsRemaining;
var intervalHandle;

function resetPage() {
    document.getElementById("inputArea").style.display = "block";
}

function tick() {
    // grab the h1
    var timeDisplay = document.getElementById("time") || '0:00';
    
    // turn seconds into mm:ss
    var min = Math.floor(secondsRemaining / 60);
    var sec = secondsRemaining - (min * 60);
    
    // add a leading zero (as a string value) if seconds less than 10
    if (sec < 10) {
        sec = "0" + sec;
    }
    // concatenate with colon
    var message = min + ":" + sec;
    // now change the display
    timeDisplay.innerHTML = message;
    
    // stop if down to zero
    if (secondsRemaining === 0) {
        swal({
          title: "Sorry! Your Order is Little Bit late",
          text: "Its on its way stay connected",
          type: "warning",
        });
        clearInterval(intervalHandle);
        resetPage();
    }
    // subtract from seconds remaining
    secondsRemaining--;
}

function startCountdown() {
    // how many seconds?
    secondsRemaining =  (gon.minutes * 60) + parseInt(gon.seconds);
    // every second, call the "tick" function
    intervalHandle = setInterval(tick, 1000);
    // hide the form
}
if ($("#time").length > 0) {
  startCountdown();
}

});