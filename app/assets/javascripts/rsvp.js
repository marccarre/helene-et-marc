$(document).ready(function() {
  function moveTo(newParentElementId, childElementsClass) {
    var children = $(childElementsClass).detach();
    $(newParentElementId).append(children);    
  }

  moveTo('#adult-guest-forms', '.adult-guest-form');
  moveTo('#child-guest-forms', '.child-guest-form');
});