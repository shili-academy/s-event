$('.image_task').click(function () {
  Swal.fire({
    imageUrl: $(this).attr('src'),
    imageAlt: $(this).attr('alt'),
    width: 700,
    imageWidth: "100%",
    background: "#395B64",
    confirmButtonText: "Đóng"
  });
});
