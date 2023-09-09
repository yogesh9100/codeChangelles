trigger CaseTrigger on case (before insert, before Update)
{
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))
    {
     system.debug('Value of Trigger.New::'+ trigger.New);
      Group highpriorityQueue = [select Id FROM Group Where DeveloperName = 'High_Priority_Case_Management_Team'LIMIT 1];
    for(Case caseRecord : trigger.New)
    {
        if(caseRecord.Priority == 'High')
        {
           caseRecord.OwnerId = highPriorityQueue.Id;
        }
    }
   }

}