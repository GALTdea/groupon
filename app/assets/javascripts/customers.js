$(document).on('page:change', function () {
  $("input[type='number']").each(function(i, el) {
      el.type = "text";
      el.onfocus = function(){this.type="number";};
      el.onblur = function(){this.type="text";};
  });
});
