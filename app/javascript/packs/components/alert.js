$(document).on("turbolinks:load", function () {
  $(".flash-alert")
    .delay(10000)
    .slideUp(500, function () {
      $(".flash-alert").alert("close");
    });
});
