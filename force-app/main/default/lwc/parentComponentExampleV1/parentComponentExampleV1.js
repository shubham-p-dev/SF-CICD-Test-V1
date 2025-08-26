
import { LightningElement } from 'lwc';

export default class ParentComponentExampleV1 extends LightningElement {
    parentMessage = '';
    childMessage = '';

    messageFromShubhamEvent = '';

    // Update the parentMessage when input changes
    handleParentInput(event) {

        console.log('On change input Parent --> ',event.target.value);
        
        this.parentMessage = event.target.value;

    }

    // Handle event from child
    handleChildMessage(event) {

        console.log('custom event from child onmessagefromchild --> ',event);

        this.childMessage = event.detail; // detail is the payload from child
    }


    handleShubhamEvent(event) {

        console.log('custom event from child handleShubhamEvent --> ',event);

        let myPayload = event.detail;

        this.messageFromShubhamEvent = event.detail.myValue;

        console.log('myPayload --> ',JSON.stringify(myPayload));
        
    }


}
