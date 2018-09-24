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
//= require turbolinks
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require angular/angular
//= require angular-resource/angular-resource.js
//= require xtform
//= require datetimepicker/jquery.datetimepicker.js
//= require datetimepicker
//= require angular-bootstrap-show-errors
//= require angular-devise/lib/devise
//= require angular-ui-router
//= require chosen-jquery
//= require_tree .

var validate_options = {
    errorPlacement: function(error, element) {
        element.attr('title', error.text());
        $(".error").tooltip({
            position:
            {
                my: "left+5 center",
                at: "right center"
            },
            tooltipClass: "ttError"
        })
    }
};


var timepickerOptions = {
    datepicker:false,
    format:'H:i'
};

var datepickerOptions = {
    timepicker: false,
    format: 'Y-m-d'
};

var datetimepickerOptions = {
    timepicker: true,
    format: 'd-m-Y H:i'
};

$(document).on('ready page:load', function() {
    //$('select').chosen({allow_single_deselect: true});
    //$('.datepicker').datepicker({dateFormat: 'yy-mm-dd'});
    //$('.image-upload').on('change', handleFileSelect);
    //$('form').validate(validate_options);
});

function handleFileSelect(evt) {
    var files = evt.target.files; // FileList object
    var imageDivId = $(evt.target).data('image-id');

    var file = files[0];
    if (file.type.match('image.*')) { // Only process image files.
        var reader = new FileReader();
        reader.onload = (function(theFile) {
            return function(e) {
                $('#' + imageDivId).attr('src', e.target.result);
            };
        })(file);

        // Read in the image file as a data URL.
        reader.readAsDataURL(file);
    }
}