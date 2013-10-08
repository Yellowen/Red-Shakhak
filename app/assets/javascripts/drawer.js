document.drawer = {
    el: "#drawer",
    content: "#drawer-content",
    effect_duration: 300,

    toggle_drawer: function() {
        if ($(this.el).hasClass("opened")) {
            this.close_drawer();
        }
        else {
            this.open_drawer();
        }
    },

    open_drawer: function(){
        console.log("Drawer opened");
        if (! this.is_open()) {
            $(this.el).slideDown(this.effect_duration);
            $(this.el).addClass("opened");
        }
    },
    close_drawer: function(){
        console.log("Drawer closed");
        if (this.is_open()) {
            $(this.el).slideUp(this.effect_duration);
            $(this.el).removeClass("opened");
        }
    },
    show: function(){
        this.open_drawer();
    },

    is_open: function(){
        if ($(this.el).hasClass("opened")) {
            return true;
        }
        return false;
    },

    set_height_to_content: function(){
        var cheight = $(this.content).height();
        console.log(cheight);
        console.log($(this.el).css("height"));
        $(this.el).css("height", cheight);
    },

    load_remote_content: function(obj){
        // obj: {url: , data: , callback: , method: }
        // Load the remote content provided by given url and
        // show the result inside drawer and call `callback`
        // On successful run

        if (! this.is_open()) {

            if (obj.url === undefined) {
                throw "url should not be empty";
            }

            show_loading_sign();
            var that = this;

            $.ajax({
                url: obj.url,
                data: obj.data,
                async: true,
                success: function(data){
                    // Data should be HTML
                    $(that.content).html(data);

                    that.open_drawer();
                    if ($.isFunction(obj.callback)) {
                        obj.callback.call(data);
                    }
                    hide_loading_sign();

                },
                error: function(){
                    // TODO: create an error message an show on global flash
                    alert("An Error occured");
                    hide_loading_sign();
                }

            });
        }
        else {
            this.close_drawer();
        }
    }

};
