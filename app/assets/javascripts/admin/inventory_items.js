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

  $('body').on('focusout', '.stock-quantity' , function(){
    item_price = $(this).closest('.stock_quantity').prev().find('.item-price').val()
    stock_quantity = $(this).val();
    item_quantity = $(this).closest('.stock_quantity').prev().prev().prev().find('.item-quantity').val()
    total = ( parseFloat(stock_quantity) / parseFloat(item_quantity) ) * parseFloat(item_price)
    $(this).closest('.form-group').siblings('.total_price').find('.total-price').val(total)

  });

  $('body').on('focusout', '.item-discount', function(){
    discount = $(this).val()
    total_price = $(this).closest('.item_discount').prev().find('.total-price').val()
    after_discount_total =  parseFloat(total_price) - (parseFloat(discount))
    $(this).closest('.form-group').siblings('.total_expense').find('.total-expense').val(after_discount_total)
  });

  // $('.append-form').on('click', function(){
  //   append_data = $('.collect-data').html();
  //   $('.form-to-append').append(append_data);
  // });
});