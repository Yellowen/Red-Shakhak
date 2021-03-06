// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require variables
//= require functions
//= require vendor/custom.modernizr
//= require jquery
//= require jquery_ujs
//= require foundation
//= require lib/humanize
//= require turbolinks
//= require jquery.turbolinks
//= require wizard/form_wizard
//= require advertises
//= require base
//= require lib/jquery.qtip.js
//= require_tree .

$(function(){
    $("#wizard").wizard({});
    $(document).foundation();
    var tooltip = $('[data-tip!=""]').qtip({ // Grab all elements with a non-blank data-tooltip attr.
        content: {
            attr: 'data-tip'
        },
        position: {
            my: 'bottom center',
            at: 'top center',
            viewport: $(window)
        },
        style: {
            classes: 'qtip-tipsy',
            tip: {
                corner: "bottom center"
            }
        }
    });


});
