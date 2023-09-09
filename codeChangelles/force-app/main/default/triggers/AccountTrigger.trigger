trigger AccountTrigger on Account (before insert,before update,after insert,after update) {
/*List<Contact>ConList = new List<Contact>();
       //List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE AccountId = :acc.Id];
    // Collect Account IDs from the trigger context
    for (Account acc : Trigger.new) {
        
        List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE AccountId = :acc.Id];
        
        for (Contact con : contacts) {
            
            con.Description = 'Updated';
                ConList.add(Con);
        }
        if(!ConList.isEmpty())
        {
          Update ConList;  // DML inside a loop (not bulkified)
    }
}*/
}