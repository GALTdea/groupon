$(document).on('page:change', function () {

  $(".button.decrement").on("click", function(event) {
    amount_field = $(this).parent().parent().find('#amount');
    if (Number(amount_field.val()) > 0) {
      amount_field.val(Number(amount_field.val()) - 1);
    }
  });

  $(".button.increment").on("click", function(event) {
    amount_field = $(this).parent().parent().find('#amount');
    amount_field.val(Number(amount_field.val()) + 1);
  });

});

