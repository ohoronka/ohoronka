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
//= require jquery3
//= require popper
//= require rails-ujs
//= require turbolinks
//= require cable
//= require jsrender
//= require bootstrap-sprockets
//= require jquery.backstretch
//= require jquery.timeago
//= require jstz
//= require js.cookie


var flash = function (message) {
    $('#flash').prepend('<div class="alert alert-dark alert-dismissible fade show" role="alert"><button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span> </button>' + message + '</div>');
};

$( document ).on('turbolinks:load', function() {
    jQuery(".js-timeago").timeago();
    setInterval(function(){jQuery(".js-timeago").timeago();}, 7000);

    var tz = jstz.determine();
    Cookies.set('timezone', tz.name());
});