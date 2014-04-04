require.config({
    paths: {
        "app": "../app"
    }
});
require(['splunkjs/mvc/simplexml/ready!',
         '/static/app/TemplateForXenApp/components/datepicker/js/bootstrap-datepicker.js'], function(){
    require(['splunkjs/ready!'], function(){
        // The splunkjs/ready loader script will automatically instantiate all elements
        // declared in the dashboard's HTML.
        
       
        $("#field1").find("input").datepicker();
    });
});