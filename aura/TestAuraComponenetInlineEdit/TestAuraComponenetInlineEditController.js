({ //DataTableInActionController.js
    init: function (cmp, event, helper) {
        cmp.set('v.columns', helper.getColumnDefinitions());
        
        
        //https://developers.google.com/web/fundamentals/getting-started/primers/promises.
        //https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/js_promises.htm
        console.log('initial rows = ' + cmp.get('v.initialRows'));
        var dataPromise = helper.fetchData(cmp, cmp.get('v.initialRows'));
        
        
        // cmp.set('v.dataTableSchema', fetchData);
        dataPromise.then($A.getCallback(function(results) {
            //console.log('results');console.log(results);
            cmp.set('v.mydata', results);
            cmp.set("v.message", 'mydata set in init on startup');
        }));
        
        
        
    },//init
    
    updateSelectedText: function (cmp, event) {
        var selectedRows = event.getParam('selectedRows');
        cmp.set('v.selectedRowsCount', selectedRows.length);
    },
    storeColumnWidths: function (cmp, event, helper) {
        helper.storeColumnWidths(event.getParam('columnWidths'));
    },
    addRowsToBeginning: function (cmp, event, helper) {
        var fetchData = cmp.get('v.dataTableSchema'),
            dataPromise = helper.fetchData(cmp, cmp.get('v.rowsToAdd'));


        dataPromise.then($A.getCallback(function (data) {
            var currentData = cmp.get('v.data');
            var newData = data.concat(currentData);
            cmp.set('v.data', newData);
        }));
    },
    addRowsToEnd: function (cmp, event, helper) {
        var fetchData = cmp.get('v.dataTableSchema'),
            dataPromise = helper.fetchData(cmp, cmp.get('v.rowsToAdd'));

        dataPromise.then($A.getCallback(function (data) {
            var currentData = cmp.get('v.data');
            var newData = currentData.concat(data);
            cmp.set('v.data', newData);
        }));
    },
    clearRows: function (cmp) {
        cmp.set('v.data', []);
    },
    resetColumns: function (cmp, event, helper) {
        helper.resetLocalStorage();
        cmp.set('v.columns', helper.getColumnDefinitions());
    },
    updateColumnSorting: function (cmp, event, helper) {
        cmp.set('v.isLoading', true);
        // We use the setTimeout method here to simulate the async
        // process of the sorting data, so that user will see the
        // spinner loading when the data is being sorted.
        setTimeout($A.getCallback(function() {
            var fieldName = event.getParam('fieldName');
            var sortDirection = event.getParam('sortDirection');
            cmp.set("v.sortedBy", fieldName);
            cmp.set("v.sortedDirection", sortDirection);
            helper.sortData(cmp, fieldName, sortDirection);
            cmp.set('v.isLoading', false);
        }), 0);
    },
    handleRowAction: function (cmp, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        switch (action.name) {
            case 'view_details':
                helper.showRowDetails(row);
                break;
            case 'edit_status':
                helper.editRowStatus(cmp, row, action);
                break;
            default:
                helper.showRowDetails(row);
                break;
        }
    }
}) //DataTableInActionController.js