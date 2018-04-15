// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require bugsnag-js/dist/bugsnag.js
//= require jquery3
//= require popper
//= require turbolinks
//= require cable
//= require rails-ujs
//= require jsrender
//= require bootstrap-sprockets
//= require jquery.backstretch
//= require jstz
//= require js.cookie
//= require jquery-touchswipe/jquery.touchSwipe
//= require typeahead.js/dist/typeahead.bundle.js

// sidebar
//= require jquery.browser/dist/jquery.browser
//= require metismenu/dist/metisMenu.js
//= require sidebar

//= require i18n/translations
//= require constants

var flash = function (message) {
  console.log('flash was called');
    var msg = $('<div class="alert alert-dark alert-dismissible fade show" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span> </button>' + message + '</div>');
    $('#flash').prepend(msg);
    setTimeout(function(){$(msg).hide(500)}, 5000);
};

$( document ).on('turbolinks:load', function() {
    var tz = jstz.determine();
    Cookies.set('timezone', tz.name());
});
