$(function() {
    $(".dashboard-show-overload").on("click",function(event){
        //$(this).preventDefault();
        $(".overload").not($(this).parent().parent().find(".overload")).slideUp();
        $(this).parent().parent().find(".overload").slideDown(200);
    });
});
