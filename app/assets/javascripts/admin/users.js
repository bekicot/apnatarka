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

  $('#inventry #fields').on('cocoon:after-insert', function(e, inserted_item) {
    $(".in_fields:last input, .in_fields:last select").each(function(i) {
      val1 = $(this).attr('name').split('[')[0]
      val2 = val1.concat(('['+ $('.in_fields').length).concat($(this).attr('name').split('[')[1]))
      val3 = $(this).attr('name').split('[')[2]
      value = val2.concat('['+val3)
      $(this).attr('name', value);
    });
  });
});
