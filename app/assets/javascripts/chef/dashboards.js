$(document).ready(function(){
	
	$(function () {
    $('#chefdatetimepicker1').datetimepicker({
    format:'YYYY-MM-DD',
    defaultDate: new Date
    });
  });

  $('body').on('focusout', '.chef-orders-by-date' , function(){
    date = $(this).val()
   $.ajax({
     type: 'GET',
     url: '/chef/dashboards/order_by_date',
     dataType: 'script',
     data : { date: date}
     });
  });

  $(function () {
    $('#chefdatetimepicker2').datetimepicker({
    format:'YYYY-MM-DD'
    });
  });
  
  $('body').on('focusout', '.chef-inventory-by-date' , function(){
    date = $(this).val()
   $.ajax({
     type: 'GET',
     url: '/chef/dashboards/inventory_by_date',
     dataType: 'script',
     data : { date: date}
     });
  });
});