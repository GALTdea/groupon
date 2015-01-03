$(document).on('page:change', function () {

  var sign = false;

  if (typeof $('.ui.accordion').accordion === "function") {
    $('.ui.accordion').
      accordion()
    ;
  }
});

  // $("form").submit(function(event) {
  //   if (sign) {
  //     $(this).find("#dybtn").val("更 新 订 单");
  //     $(this).find(':input[type="number"]').prop('disabled', false);
  //     $(this).find('.basic.button').removeClass('disabled');
  //     $(this).find('#dybtn').removeClass('red');
  //     $(this).find('#dybtn').addClass('green');
  //     sign = false;
  //     event.preventDefault();
  //   } else {
  //     $(this).find("#dybtn").val("编 辑 订 单");
  //     $(':input[type="number"]').prop('disabled', true);
  //     $('.basic.button').addClass('disabled');
  //     sign = true;
  //   }
  // });


