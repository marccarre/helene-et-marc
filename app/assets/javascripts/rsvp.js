$(document).ready(function() {

  $('.adult-guest-form > a').first().hide();
  $('div#checkboxes-events-attended').hide();
  $('input#btn-rsvp-submit').prop('disabled', true);

  $('select#dropdown-booking-is-coming').change(function() {
    var isComing = $('select#dropdown-booking-is-coming').val();
    if (isComing == 'true') {
      $('div#checkboxes-events-attended').show();
      $('input.wedding-event-checkbox').prop('checked', true);
      $('input#btn-rsvp-submit').prop('disabled', false);
    } else if (isComing == 'false') {
      $('div#checkboxes-events-attended').hide();
      $('input.wedding-event-checkbox').prop('checked', false);
      $('input#btn-rsvp-submit').prop('disabled', false);
    } else {
      $('div#checkboxes-events-attended').hide();
      $('input.wedding-event-checkbox').prop('checked', false);
      $('input#btn-rsvp-submit').prop('disabled', true);
    }
  });

  function moveTo(newParentElementId, childElementsClass) {
    var children = $(childElementsClass).detach();
    $(newParentElementId).append(children);    
  }

  moveTo('#adult-guest-forms', '.adult-guest-form');
  moveTo('#child-guest-forms', '.child-guest-form');

});