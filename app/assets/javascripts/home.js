//= require lib/masonry.pkgd

$(function(){
    var $container = $('#adbox');

    $container.masonry({
	columnWidth: 100,
	gutter: 2,
	isOriginLeft: false,
	itemSelector: '.box'
    });

});
