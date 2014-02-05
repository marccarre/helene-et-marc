$(document).ready(function() {
  var datetime_picker = $('#wedding_car_departure_time');

  // Transform into datetime picker:
  datetime_picker.datetimepicker({
    language: datetime_picker.data('datetime-format')
  });

  // Hide label and set name as placeholder instead of the example value 
  // (see also application_helper.rb's tbs3_inline_datetime_field):
  var label = datetime_picker.siblings('label');
  label.addClass('sr-only');
  datetime_picker.attr('placeholder', label.text().replace(':', '').trim());
});
