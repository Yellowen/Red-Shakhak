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
//= require lib/jquery.qtip.min.js
//= require_tree .


$(function(){
    $("#wizard").wizard({});
    $(document).foundation();
    $('[data-tip!=""]').qtip({ // Grab all elements with a non-blank data-tooltip attr.
        content: {
            attr: 'data-tip' // Tell qTip2 to look inside this attr for it's content
        },
        position: {
            my: 'top center'
        },
        style: {
            classes: 'qtip-dark qtip-shadow'
        }
    });


});
