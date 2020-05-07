$(document).ready(function(){
	$(function () {
  		$('#riderdatetimepicker1').datetimepicker({
  		format:'YYYY-MM-DD',
      defaultDate: new Date
  		})
      // .on('dp.change', function(e){
    //     debugger
    //   		date = $(this).val()
    //   		$.ajax({
    //     		type: 'GET',
    //     		url: '/rider/dashboards/record_by_date',
    //     		dataType: 'script',
    //     		data : { date: date}
    //    		});
    // });
  });

  $('body').on('focusout', '.order-history' , function(){
    date = $(this).val()
   $.ajax({
     type: 'GET',
     url: '/rider/dashboards/record_by_date',
     dataType: 'script',
     data : { date: date}
     });
  });

  $(function () {
    $('#riderdatetimepicker2').datetimepicker({
    format:'YYYY-MM-DD'
    });
  });

  $('body').on('focusout', '.rider-history' , function(){
    date = $(this).val()
   $.ajax({
     type: 'GET',
     url: '/rider/dashboards/history_by_date',
     dataType: 'script',
     data : { date: date}
     });
  });
});