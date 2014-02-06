// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require turbolinks
//= require jquery_nested_form

//= require bootstrap

//= require moment
//= require bootstrap-datetimepicker
//= require moment/en-gb
//= require moment/fr
//= require locales/bootstrap-datetimepicker.en-gb
//= require locales/bootstrap-datetimepicker.fr

//= require_tree .

$(document).ready(function() {
  // Progressively enhance 'collapsible' UI elements.

  // Collapsibles are initially collapsed:
  $('.collapsible').addClass('collapse');

  // Create toggle buttons in data-toggle links, and initialized as collapsed:
  $("a[data-toggle='collapse']")
    .data('collapsed', true)
    .html("<button type='button' class='btn btn-link btn-collapsible'><span class='glyphicon glyphicon-plus-sign'></span></button>");

  // On click: change look of toggle and state (collapsed set to true/false):
  $("a[data-toggle='collapse']").click(function(e) {
    if ($(this).data('collapsed')) {
      $(this)
        .data('collapsed', false)
        .find('button > span')
        .removeClass('glyphicon-plus-sign')
        .addClass('glyphicon-minus-sign');
    } else {
      $(this)
        .data('collapsed', true)
        .find('button > span')
        .removeClass('glyphicon-minus-sign')
        .addClass('glyphicon-plus-sign');
    }
  });
});