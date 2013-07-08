var Advertise = Backbone.Model.extend({
    defaults: {
    },
    urlRoot: "/advertises",
    initialize: function(){
    }
});

var Advertises = Backbone.Collection.extend({
    model: Advertise,
    url: "/advertises",
});
