$(document).ready(function() {

  $('div.collapsible').addClass('collapse');

  $("a[data-toggle='collapse']").append("(+)");

  $("a[data-toggle='collapse']").click(function() {
    if ($(this).text() == '(+)') {
      $(this).text('(-)');
    } else {
      $(this).text('(+)');
    }
  });

  $("div#").hide();
  
});