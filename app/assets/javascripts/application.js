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
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require jquery.turbolinks
//= require lib/humanize
//= require advertises
//= require lib/jquery.qtip.js
//= require_directory .
$(function(){
    $(document).foundation();
    fist_page_ads_tooltip();
    setup_global_tooltip();
});
