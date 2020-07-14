import { LightningElement, api } from 'lwc';

import getRecords from '@salesforce/apex/AA_ContactViewGrouping.getRecords';

export default class ContactCategories extends LightningElement {

    @api recordId
    @api selectedView;
    @api contactList = [];
    @api sortAscContact = false; 

    connectedCallback(){
        console.log('Has record Id?: ' + this.recordId);
        console.log('Selected view? ' + this.selectedView);
        getRecords({
                    recordId: this.recordId,
                    selectedView: this.selectedView
                    })
            .then(
                result=>{
                        this.contactList = result;
                        }
                )
            .catch(
                error=>{
                    console.log('Error Fetching contactList: ' + error.message);
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

    openItem(event){
        event.preventDefault();
        var id = event.target.value;
        var url = '/' + id;
        window.open(url);
        }

}