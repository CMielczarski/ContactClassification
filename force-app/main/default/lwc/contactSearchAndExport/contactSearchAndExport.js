import { LightningElement, api} from 'lwc';

//import getRecordsAlt from '@salesforce/apex/AA_ContactViewGrouping.getRecordsAlt';
//import getRegionChoices from '@salesforce/apex/AA_ContactViewGrouping.getRegionChoices';
//import getTitleChoices from '@salesforce/apex/AA_ContactViewGrouping.getTitleChoices';

export default class ContactSearchAndExport extends LightningElement {

/*    @api selTitles = [];
    @api selStates = [];
    @api selectedView = 'All';
    @api regionFilter = ['AK'];
    @api sortAscContact = false;
    @api showForm = false;
    @api showMessage = false;
    @api objectRecords = [];
    @api Spinner;
    @api contactList = [];

    connectedCallback(){
        getTitleChoices()
            .then(
                result=>{
                    this.selTitles = result;
                    getRegionChoices()
                        .then(
                            result=>{
                                var stockData = result;
                                var tempList = [];
                                if(stockData !== null){
                                    for(var i = 0; i < stockData.length; i++){
                                        tempList.push({value: stockData[i], label: stockData[i]});
                                        }
                                    }
                                this.selStates = tempList;
                                }
                            )
                        .catch(
                            error=>{
                                console.log('Error fetching state list: ' + error.message);
                                }
                            );
                        }
                    )
            .catch(
                error=>{
                    console.log('Error fetching titles: ' + error.message);
                    }
            );
        }

    setTitle(event){
        this.selectedView = event.target.value;
        }

    setState(event){
        this.regionFilter = event.target.value;
        }

    searchRecords(){
        this.Spinner = true;
        console.log('Selected Titles: ' + this.selectedView);
        console.log('Selected States: ' + this.regionFilter);
        getRecordsAlt({
                        regionFilter: this.regionFilter,
                        selectedView: this.selectedView
                    })
                .then(
                    result=>{
                        this.contactList = result;
                        this.Spinner = false;
                        if(this.contactList.length === 0){
                            this.showMessage = true;
                            }
                        else{
                            this.showMessage = false;
                            }
                    }
                    )
                .catch(
                    error=>{
                        this.Spinner = false;
                        console.log('Error fetching contacts: ' + error.message);
                    }
                );
        }

    sortContact(event){
        console.log('Sort Event Caused by: ' + event.target.name);
            var field = event.target.name;
            var sortAsc = this.sortAscContact;
            let records = [...this.contactList];
            
            var key = (a) => a[field]; 
            var reverse;
            if(sortAsc === false){
                reverse = -1;
                sortAsc = true;
                }
            else{
                reverse = 1;
                sortAsc = false;
                }
                this.sortAscContact = sortAsc;
                this.sortFieldContact = field;
                this.contactList = records;
            records.sort((a,b) => {
                let valueA = key(a) ? key(a).toLowerCase() : '';
                let valueB = key(b) ? key(b).toLowerCase() : '';
                return reverse * ((valueA > valueB) - (valueB > valueA));
                });
            this.sortAsc = sortAsc;
            this.sortField = field;
        this.contactList = records;
        }

    newPopup(){
        this.activeClass = 'slds-modal slds-fade-in-open slds-modal_large';
        this.activeClass2 = 'slds-backdrop--open';
        this.showForm = true;
        console.log('Show Form');
        }
        
    closeNewModal(){
        this.activeClass = null;
        this.activeClass2 = null;
        this.showForm = false;
        }

    openItem(event){
        event.preventDefault();
        var id = event.target.value;
        var url = '/' + id;
        window.open(url);
        }
    
    downloadCsvAllRecords(){
            this.Spinner = true;
            var stockData = this.contactList;
            this.objectRecords = [];
            this.objectRecords = stockData;
            var csv;
            csv = this.convertArrayOfObjectsToCSV();
            if(csv == null || csv == undefined){
                this.Spinner = false;
                return;
                }
            else{
                let downloadElement = document.createElement('a');
                downloadElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
                downloadElement.target = '_self';
                downloadElement.setAttribute("download","download");
                downloadElement.download = 'ContactData.csv';
                downloadElement.click(); 
                    
                this.Spinner = false;
                }
        }
    
    convertArrayOfObjectsToCSV(){
        var objectRecords = this.objectRecords;
        var csvStringResult, counter, keys, columnDivider, lineDivider;
        if (objectRecords == null || !objectRecords.length){
            console.log('Object Records Empty');
            this.Spinner = false;
            return null;
            }
        columnDivider = ',';
        lineDivider =  '\n';
        keys = ['Id', 'Status'];
            
        csvStringResult = '';
        csvStringResult += keys.join(columnDivider);
        csvStringResult += lineDivider;
        try{
            if(objectRecords !== undefined){
                for(var i=0; i < objectRecords.length; i++){
                counter = 0;
                if(objectRecords[i] !== undefined){
                    for(var x = 0; x < objectRecords[i].length; x++){
                        for(var sTempkey in keys){
                            var skey = keys[sTempkey] ;  
                            // add , [comma] after every String value,. [except first]
                            if(counter > 0){ 
                                csvStringResult += columnDivider; 
                                }
                            if(skey == 'Id'){
                                if(objectRecords[i].Id !== undefined){  
                                    csvStringResult += '"'+ objectRecords[i].Id+'"';
                                    csvStringResult += columnDivider;
                                    csvStringResult += 'Campaign Member';
                                    }
                                else{
                                    csvStringResult += '"'+ ' ' +'"';
                                    }
                                }   
                        counter++; 
                        }
                        counter = 0;
                        csvStringResult += lineDivider;
                        }
                    }
                }
            }
            else{
                console.log('ObjectRecords undefined');
                this.Spinner = false;
                }
            }
            catch(err){
                console.log('Error with export: ' + err.message);
                this.Spinner = false;
            }
            return csvStringResult;
            }*/

}