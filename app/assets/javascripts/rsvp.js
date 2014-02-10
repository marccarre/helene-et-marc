$(document).ready(function() {

  // Remove delete button for 1st (default) guest:
  $('.adult-guest-form > a').first().hide();

  function areAllEventsUnchecked() {
    var allUnchecked = true;
    $('input.wedding-event-checkbox').each(function() {
      if ($(this).is(':checked')) {
        allUnchecked = false;
        return false; // Break from 'each loop'.
      }
    });
    return allUnchecked;
  }

  function changeFormsState() {
    var isComing      = $('select#dropdown-booking-is-coming').val();
    var previousValue = $('select#dropdown-booking-is-coming').data('previous-value');

    if (isComing == 'true') {
      $('div#checkboxes-events-attended').show();
      if ((previousValue == '' || previousValue == 'false') && areAllEventsUnchecked()) {
        $('input.wedding-event-checkbox').prop('checked', true);
      }
      $('input#btn-rsvp-submit').prop('disabled', false);
    } else if (isComing == 'false') {
      $('div#checkboxes-events-attended').hide();
      $('input.wedding-event-checkbox').prop('checked', false);
      $('input#btn-rsvp-submit').prop('disabled', false);
    } else {
      $('div#checkboxes-events-attended').hide();     
      $('input#btn-rsvp-submit').prop('disabled', true);
    }

    // Store value for next time:
    $('select#dropdown-booking-is-coming').data('previous-value', isComing);
  }

  // Initially change form's state according to, for example, values previously entered, in case form failed:
  changeFormsState(true);

  // Behave similarly every time the 'is coming' dropdown changes value:
  $('select#dropdown-booking-is-coming').change(function() {
    changeFormsState(false);
  });


  function moveTo(newParentElementId, childElementsClass) {
    var children = $(childElementsClass).detach();
    $(newParentElementId).append(children);    
  }

  // Move all input blocks under the right parent div:
  moveTo('#adult-guest-forms', '.adult-guest-form');
  moveTo('#child-guest-forms', '.child-guest-form');

});