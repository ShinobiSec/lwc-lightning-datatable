import { LightningElement, track, wire, api } from 'lwc';
import getContacts from '@salesforce/apex/LightningDatatableController.getContacts';

export default class lightningDatatable extends LightningElement {
    @api recordId;
    key = '';
    email = '';
    @track contacts;
    rowLimit = 2;

    columns = [
        { label: 'Name', fieldName: 'nameUrl', type: 'url', typeAttributes: { label: { fieldName: 'Name' }, target: '_blank' } },
        { label: 'Contacts Title', fieldName: 'Title', type: 'text' },
        { label: 'Email', fieldName: 'Email', type: 'email', typeAttributes: { label: { fieldName: 'Email' }, target: '_blank' } },
        { label: 'Created Date', fieldName: 'CreatedDate', type: 'date', typeAttributes: { day: 'numeric', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true } }
    ];

    @wire(getContacts, { accountId: '$recordId', name: '$key', email: '$email', rows: '$rowLimit' })
    wiredContacts({ data, error }) {
        if (data) {
            this.contacts = data.map(record => ({
                ...record,
                nameUrl: `/lightning/r/${record.Id}/view`
            }));
        } else if (error) {
            console.error(error);
        }
    }
     
    updateKey(event) {
        this.key = event.target.value;
        this.email = '';
    }

    updateEmail(event) {
        this.email = event.target.value;
        this.key = '';
    }
    
    clearFilters() {
        this.key = '';
        this.email = '';
    }

    handleViewMoreRecords() {
        this.rowLimit += 25;
    }
}