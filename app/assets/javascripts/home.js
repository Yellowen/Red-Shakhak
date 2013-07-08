//= require lib/masonry.pkgd
//= require lib/documentcloud/underscore-min
//= require lib/documentcloud/backbone-min
//= require router
//= require models

$(function(){
    var $container = $('#adbox');

    $container.masonry({
	columnWidth: 100,
	gutter: 2,
	isOriginLeft: false,
	itemSelector: '.box'
    });

});
