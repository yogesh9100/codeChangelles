@isTest

public class LoadDataSampleTest {

 

 

     static testmethod void SampleDataForTest()

    {

       

        //Load CSV file saved in static resource

        List<SObject> lstAcc = Test.loadData(Account.sObjectType,'Account');

        List<SObject> lstCon = Test.loadData(Contact.sObjectType,'Contact');

        //Confirm that total number of accounts created are 3

        System.assertEquals(lstAcc.size(), 3);

        for(Account a : [SELECT Id, Name, (SELECT FirstName,LastName FROM Contacts) FROM Account where Id IN :lstAcc])

        {

            //confirm that every Account has associated child contact

        System.assertNotEquals(null, a.contacts);

            //confirm that every Account has exactly 2 contacts

        System.assertEquals(a.contacts.size(), 2);

        }

       

        //List<Account> AccsList= [SELECT Id, Name FROM Account];

        List<Account> accList = [SELECT Id, Name FROM Account where Id IN :lstAcc];

        for(Account accRecord : accList){

            System.debug('Accounts :: ' + accRecord);

        }

       

        List<Contact> conList = [SELECT Account.Id,FirstName, LastName FROM Contact where Id IN :lstCon];

        for(Contact conRecord : conList){

            System.debug('Contacts :: ' + conRecord);

        }

}
}