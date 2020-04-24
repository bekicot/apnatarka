$(document).ready(function(){
  $('#user_state').on('change', function(){
    var state = $(this).val();
    $.ajax({
      type: 'GET',
      url: '/admin/users/get_cities',
      dataType: 'json',
      data: {state: state}, 
      success: function(data){
        var $mySelect = $('#user_city');
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

  $('.user-role').on('change', function(){
    user_role = $(this).val()
    $.ajax({
      type: 'GET',
      url: '/admin/users/user_roles',
      dataType: 'script',
      data : { user_role: user_role}
     });
  }); 

  $('#fields').on('cocoon:after-insert', function(e, inserted_item) {
    debugger
    var num;
    num = $('.fields').length;
    return inserted_item.find('.field-label').html('Field #' + num);
  });
});
