require(['jquery'], function($){
    $(function() {
		// When the DOM is ready, move the modal buttons where we want them to be displayed
                
		$("#chartAvailMem .panel-head").find("h3").after($("#btnAvailMemDesc"));
		$("#chartPagesPerSec .panel-head").find("h3").after($("#btnPagesPerSecDesc"));
		$("#chartWorkingSet .panel-head").find("h3").after($("#btnWorkingSetDesc"));
	});
});