
import { LightningElement, api } from 'lwc';

export default class ChildComponentExampleV1 extends LightningElement {
    @api messageFromParent; // receive data from parent
    childMessage = '';

    handleChildInput(event) {

        console.log('On change input Child --> ',event.target.value);

        this.childMessage = event.target.value;
        this.sendMessageToParent();
    }

    sendMessageToParent() {
        // Create and dispatch custom event
        const eventToParent = new CustomEvent('messagefromchild', {
            detail: this.childMessage
        });
        this.dispatchEvent(eventToParent);
    }


    sendMessageToParentShubhamEvent() {

        const thisCustomEvent = new CustomEvent('shubhamevent', {
            detail: {
                myValue: 'ILU'
            }
        })

        this.dispatchEvent(thisCustomEvent);
    
    }

}
