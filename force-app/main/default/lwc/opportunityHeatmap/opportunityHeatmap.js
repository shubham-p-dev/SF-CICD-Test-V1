import { LightningElement, api } from 'lwc';

export default class OpportunityHeatmap extends LightningElement {

    @api recordId;

    connectedCallback() {
        console.log('Opp record id ', this.recordId)
    }


    stages = [
        { id: 'path-1', title: 'Clear AP', bgClass: "bgGreen"},
        { id: 'path-2', title: 'Clear Compliance Cloud', bgClass: "bgRed"},
        { id: 'path-3', title: 'E-invoicing & E-Way Bill', bgClass: "bgGreen"},
        { id: 'path-4', title: 'GST', bgClass: "bgRed"},
        { id: 'path-5', title: 'Invoice Discounting', bgClass: "bgGreen"},
        { id: 'path-6', title: 'Invoicing API', bgClass: "bgYellow"},
        { id: 'path-7', title: 'KYC APIs', bgClass: "bgGreen"},
        { id: 'path-8', title: 'Max', bgClass: "bgYellow"},
        { id: 'path-9', title: 'Notice Management', bgClass: "bgRed"},
        { id: 'path-10', title: 'Secretarial Automation', bgClass: "bgYellow"},
        { id: 'path-11', title: 'TDS', bgClass: "bgRed"}
    ];

}