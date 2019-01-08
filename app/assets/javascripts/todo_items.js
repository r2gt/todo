$(document).on('turbolinks:load', function() {
  $(":checkbox").click(function() {
    $(this).parents('form').submit()
  })
})