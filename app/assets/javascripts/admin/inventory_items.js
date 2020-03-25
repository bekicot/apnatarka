$(document).ready(function(){
  $(function () {
      $('#datetimepicker1').datetimepicker({
      	format:'YYYY-MM-DD HH:mm:ss'
      });
  });

  $('.inventory-item-by-year').on('change', function(){
  	month = $(this).val()
  	year = $('.year').val()
  	$.ajax({
      type: 'GET',
      url: '/admin/inventory_items/inventory_by_year',
      dataType: 'script',
      data : { year: year, month: month}
     });

  });

  // $('.append-form').on('click', function(){
  //   append_data = $('.collect-data').html();
  //   $('.form-to-append').append(append_data);
  // });
});