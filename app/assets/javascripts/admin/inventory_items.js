$(document).ready(function(){
  $(function () {
      $('#datetimepicker1').datetimepicker({
      	format:'YYYY-MM-DD HH:mm:ss'
      });
  });

  $('.append-form').on('click', function(){
    append_data = $('.collect-data').html();
    $('.form-to-append').append(append_data);
  });
});