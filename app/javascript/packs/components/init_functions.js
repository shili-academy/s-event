window.copy_clipboard = function (value) {
  navigator.clipboard.writeText(value);
  Toast.fire({ icon: "success", title: "Đã copy liên kết vào bộ nhớ tạm" });
}

window.confirm_delete = function (url) {
  swalWithBootstrapButtons.fire({
    title: 'Are you sure?',
    text: "You won't be able to revert this!",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonText: 'Yes, delete it!',
    cancelButtonText: 'No, cancel!',
    reverseButtons: true
  }).then((result) => {
    if (result.isConfirmed) {
      $.ajax({
        type: 'DELETE',
        dataType: 'script',
        url: url,
        data: {
          authenticity_token: $('[name="csrf-token"]')[0].content
        }
      });
    } else if (result.dismiss === Swal.DismissReason.cancel) {
      swalWithBootstrapButtons.fire(
        'Cancelled',
        'Your imaginary file is safe :)',
        'error'
      )
    }
  })
};
