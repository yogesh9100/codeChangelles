trigger ContractTrigger on Contract (before delete) {
    
    if(trigger.isBefore && trigger.isDelete)
    {
        system.debug('Value of Trigger.old::'+ trigger.old);
         for(contract conRecord : trigger.old)
         {
            if(conRecord.Status == 'Activated')
            {
                conRecord.addError('Activated contract cannot be deleted');
            }
         }
    }
}