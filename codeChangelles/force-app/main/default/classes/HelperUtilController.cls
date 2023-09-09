public with sharing class HelperUtilController 
{
    public static void getAllPartnerHotels() 
    {
        
        
            Account acclist = [SELECT Id, Name, BillingCountry FROM Account WHERE Is_Partner_Hotel__c = true];
            System.debug('List of all partner hotels'+ acclist);
        

    }

    public static void getEmailConfig(String ObjName)
    {


        List<Email_Configuration__mdt> emailConfig = [SELECT MasterLabel, DeveloperName, Email_Body__c, Email_Subject__c, Object_Name__c, Receipient_Emails__c FROM 
       Email_Configuration__mdt WHERE Object_Name__c =:ObjName];

       System.debug('emailConfig::' + emailConfig);

    }
   

 public static void SendEmailMessage(List<opportunity> opplst)

    {

        Email_Configuration__mdt emailConfig =[Select Masterlabel,DeveloperName,Email_Body__c,Email_Subject__c,Object_Name__c,Receipient_Emails__c from Email_Configuration__mdt where Object_Name__c='opportunity'];

       for(Opportunity opp:opplst)

       {

           if(opp.Amount>1000000)

           {

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

                string[] emailAdd=emailConfig.Receipient_Emails__c.split(',',0);

                message.toAddresses =emailAdd;

                message.optOutPolicy = 'FILTER';

                message.subject =emailConfig.Email_Subject__c;

                message.plainTextBody =emailConfig.Email_Body__c;

                Messaging.SingleEmailMessage[] messages = 

                    new List<Messaging.SingleEmailMessage> {message};

                         Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

       }
    }
}
}