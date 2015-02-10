// Calendar
// this displays information as events on a calendar

require.config({
    shim: {
        "./contrib/fullcalendar.min": {
            deps: ["jquery"],
            exports: "fullcalendar"
        }
    }
});

define(function(require, exports, module) {

    var _ = require('underscore');
    var fc = require(['./contrib/fullcalendar.min'], function (fullcalendar) {});
    var fcCSS = require("css!./contrib/fullcalendar.css");
    var SimpleSplunkView = require("splunkjs/mvc/simplesplunkview");
    
    var EventCalendar = SimpleSplunkView.extend({

        className: "custom-eventcalendar",

        options: {
            managerid: null,   
            data: "preview", 
            valueField: "count",
            dateField: "date",
            linkUrl: null,
            destFormField: null
        },

        output_mode: "json",

        initialize: function() {
            _.extend(this.options, {
                formatName: _.identity,
                formatTitle: function(d) {
                    return (d.source.name + ' -> ' + d.target.name +
                            ': ' + d.value); 
                }
            });
            SimpleSplunkView.prototype.initialize.apply(this, arguments);
        },
        
        createView: function() {
            this.$el.html("");
            var eventcalendar = fc();
            
            // The returned object gets passed to updateView as viz
            return { container: this.$el, eventcalendar: eventcalendar};
        },

        formatData: function(data) {
            var valueField = this.settings.get('valueField');
            var dateField = this.settings.get('dateField');
            var linkUrl = this.settings.get('linkUrl');
            var destFormField = this.settings.get('destFormField');
            var eventcalendar = {'events': [] };

            for (var i=0; i < data.length; i++) {
                var event = {
                    "title" : "Users: " + data[i][valueField],
                    "start" : data[i][dateField],
                    "url" : linkUrl + "?form." + destFormField + "=" + data[i][dateField].toString()
                }
                
                eventcalendar.events.push(event);
            }
            return eventcalendar; // this is passed into updateView as 'data'
        },

        updateView: function(viz, data) {
            
            // we need to clear the HTML of the element because calling fullCalendar multiple times on the
            // same element will render multiple calendars.
            this.$el.html("");
            this.$el.fullCalendar({ events:data.events });
        }
    });
    return EventCalendar;
});