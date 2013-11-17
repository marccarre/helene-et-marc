
$(document).ready(function() {
  $("a[data-toggle='collapse']").click(function() {
    if ($(this).text() == '(+)') {
      $(this).text('(-)');
    } else {
      $(this).text('(+)');
    }
  });
});