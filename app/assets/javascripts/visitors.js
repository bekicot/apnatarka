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

  var yourDateToGo = new Date(); //here you're making new Date object
    yourDateToGo.setDate(yourDateToGo.getDate() + 1); //your're setting date in this object 1 day more from now
    //you can change number of days to go by putting any number in place of 1

    var timing = setInterval( // you're making an interval - a thing, that is updating content after number of miliseconds, that you're writing after comma as second parameter
      function () {

        var currentDate = new Date().getTime(); //same thing as above
        var timeLeft = yourDateToGo - currentDate; //difference between time you set and now in miliseconds

        var days = Math.floor(timeLeft / (1000 * 60 * 60 * 24)); //conversion miliseconds on days 
        if (days < 10) days="0"+days; //if number of days is below 10, programm is writing "0" before 9, that's why you see "09" instead of "9"
        var hours = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)); //conversion miliseconds on hours
        if (hours < 10) hours="0"+hours;
        var minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60)); //conversion miliseconds on minutes 
        if (minutes < 10) minutes="0"+minutes;
        var seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);//conversion miliseconds on seconds
        if (seconds < 10) seconds="0"+seconds;

        document.getElementById("countdown").innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s"; // putting number of days, hours, minutes and seconds in div, 
        //which id is countdown

        if (timeLeft <= 0) {
          clearInterval(timing);
          document.getElementById("countdown").innerHTML = "It's over"; //if there's no time left, programm in this 2 lines is clearing interval (nothing is counting now) 
          //and you see "It's over" instead of time left
        }
      }, 1000);

      function firstExample () {

        for(;;) {
        var x = prompt("Enter number of days");
        x = parseInt(x);
        if (x>0 && x<30) break;
        else alert("Enter number between 0 and 30")

        }
       }

});