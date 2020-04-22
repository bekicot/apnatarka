$(document).ready(function(){
  $(function () {
      $('#datetimepicker1').datetimepicker({
      	format:'YYYY-MM-DD HH:mm:ss'
      });
  });

  $(function () {
      $('#datetimepicker3').datetimepicker({
        format:'YYYY-MM-DD HH:mm:ss'
      });
  });

  $(function () {
      $('#timepicker1').datetimepicker({
        format:'HH:mm'
      });
  });

  $(function () {
      $('#timepicker2').datetimepicker({
        format:'HH:mm'
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

  $('.item-quantity, .item-price').on('change', function(){
    price = $('.item-price').val();
    quantity = $('.item-quantity').val();
    total = parseFloat(price) * parseFloat(quantity)
    $('.total-price').val(total)

  });

  // $('.append-form').on('click', function(){
  //   append_data = $('.collect-data').html();
  //   $('.form-to-append').append(append_data);
  // });
});