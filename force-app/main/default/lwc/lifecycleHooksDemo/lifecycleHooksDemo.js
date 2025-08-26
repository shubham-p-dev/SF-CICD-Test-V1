import { LightningElement, track } from 'lwc';

export default class LifecycleHooksDemo extends LightningElement {
    @track counter = 0;
    hasRendered = false;

    constructor() {
        super();
        console.log('1️⃣ constructor: Component instance created');
    }

    connectedCallback() {
        console.log('2️⃣ connectedCallback: Component inserted into DOM');
        // Simulate data load
        setTimeout(() => {
            console.log('📡 Data fetched...');
            this.counter++;
        }, 1000);
    }

    renderedCallback() {
        console.log('3️⃣ renderedCallback: Template rendered/re-rendered');

        if (!this.hasRendered) {
            console.log('✅ First render complete');
            this.hasRendered = true;
        }
    }

    disconnectedCallback() {
        console.log('5️⃣ disconnectedCallback: Component removed from DOM');
    }

    errorCallback(error, stack) {
        console.error('⚠️ errorCallback: Error caught from child');
        console.error('Error:', error);
        console.error('Stack:', stack);
    }

    handleIncrease() {
        this.counter++;
    }

    handleThrowError() {
        throw new Error('Simulated child error');
    }
}
