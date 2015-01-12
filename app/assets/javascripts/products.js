
$(document).on('page:change', function () {
  $(".btn.minus").on("click", function(event) {
    amount_field = $(this).parent().parent().find('#amount');
    if (Number(amount_field.val()) > 0) {
      amount_field.val(Number(amount_field.val()) - 1);
    }
  });

  $(".btn.plus").on("click", function(event) {
    amount_field = $(this).parent().parent().find('#amount');
    amount_field.val(Number(amount_field.val()) + 1);
  });

  $(".control-item").on("click", function(event) {
    inputs = $(this).parent().find('.control-item input').prop('disabled', true);

    input = $(this).parent().find('.active input');

    if (input.is(":disabled")) {
      input.removeAttr("disabled");
    } 
  });

  $("#delete").on("click", function(event) {
    console.log("click delete");
    console.log($(".delete-form"));
    $(".delete-form").submit();
    console.log("delete submited");
  });
});

