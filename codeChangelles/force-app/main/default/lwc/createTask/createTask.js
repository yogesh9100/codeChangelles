import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import saveToDo from '@salesforce/apex/ToDoController.saveToDo';

export default class CreateTask extends LightningElement {
    @api targetParent;
    taskTitle;
    dueDate;  
    showDueDate = false;
    showSave = false;
    
    connectedCallback(){
        console.log('### Target Parent: ' + this.targetParent);
    }


    handleOnChange(event) {
        const field = event.target.name;
        if(field === 'taskTitle') {
            this.taskTitle = event.target.value;
            if(this.taskTitle != '') {
                this.showDueDate = true;
            } else {
                this.showDueDate = false;
            }
        } 
        if(field === 'dueDate') {
            this.dueDate = event.target.value;
            (this.dueDate !== '' && this.targetParent != true) ? (this.showSave = true) : (this.showSave = false);
        }
    }

    handleClick() {
        console.log('### Button Clicked on child');
        saveToDo({title: this.taskTitle, dueDate: this.dueDate})
            .then((result) => {
                if(result === 'Success') {
                    this.taskTitle = "";
                    this.dueDate = "";

                    const evt = new ShowToastEvent({
                        title: 'Success',
                        message: 'New item has been added in your todo list',
                        variant: 'success'
                    });
                    this.dispatchEvent(evt);
                    this.dispatchEvent(new CustomEvent('refreshtodo'));
                    if(this.targetParent === true) {
                        const selectedEvent = new CustomEvent('closeaction', {
                            detail: result
                        });
                        this.dispatchEvent(selectedEvent);
                    }
                }
            })
            .catch((error) => {
                console.log(error)

                const evt = new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                });
                this.dispatchEvent(evt);
            })
    }

    @api
    handleParentClick() {
        this.handleClick();
    }
}