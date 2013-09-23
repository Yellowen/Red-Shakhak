$(function(){
    $(".close").on("click", function(event){
	$("#" + $(this).data("target")).hide();
    });
});
