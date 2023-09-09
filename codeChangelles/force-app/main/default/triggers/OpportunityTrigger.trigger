trigger OpportunityTrigger on Opportunity (after insert, after update) 
{

    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
    {
        /*List<Opportunity> lstHighSevOpp = new List<Opportunity>();

        for(Opportunity OpportunityRec : trigger.new)
        {
            if(OpportunityRec.ExpectedRevenue > 1000000)
            {
                lstHighSevOpp.add(OpportunityRec);
            }
        }

        HelperUtilController.getEmailConfig(lstHighSevOpp);
    }*/
     HelperUtilController.SendEmailMessage(trigger.new);
}

}