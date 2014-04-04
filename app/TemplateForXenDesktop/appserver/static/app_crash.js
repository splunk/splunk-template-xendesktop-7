require([
    'underscore',
    'jquery',
    'splunkjs/mvc',
    'splunkjs/mvc/tableview',
    'splunkjs/mvc/simplexml/ready!'
], function(_, $, mvc, TableView) {
    
    var CustomTooltipRenderer = TableView.BaseCellRenderer.extend({
        canRender: function(cell) {
            return cell.field === 'Message';
        },
        render: function($td, cell) {
            
            var message = cell.value;
            var tip = cell.value;
            
            if(message.length > 48) { message = message.substring(0,47) + "..." }
            
            $td.html(_.template('<a href="#" data-toggle="tooltip" data-placement="left" data-html="true" title="<%- tip%>"><%- message%></a>', {
                tip: tip,
                message: message
            }));
            
            $td.children('[data-toggle="tooltip"]').tooltip();
        }
    });
    
    mvc.Components.get('tblCrashReport').getVisualization(function(tableView) {
        
        // Register custom cell renderer
        tableView.table.addCellRenderer(new CustomTooltipRenderer());

        // Force the table to re-render
        tableView.table.render();
    });
    
});
