require(['jquery'], function($){
    $(function() {
		// When the DOM is ready we move the input elements into the panels
		// where we want them to be displayed
                
		$('#field4').prependTo($('#tblMemMetrics .panel-body')).find('label').hide();
                $('#field5').prependTo($('#tblDiskMetrics .panel-body')).find('label').hide();
	});
});