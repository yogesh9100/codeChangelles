trigger ShareAccountWithAuditMember on Account (after insert, after update) {
    if (trigger.IsAfter && (trigger.isInsert || trigger.isUpdate)) {

        List<AccountShare> accountShareList = new List<AccountShare>();

        Set<Id> accountIdsToUpdate = new Set<Id>();

 

        for (Account acc : Trigger.new) {

            // Check if Audit_Team_Member__c field is changed or not null

            if ((trigger.isInsert || acc.Audit_Team_Member__c != Trigger.oldMap.get(acc.Id).Audit_Team_Member__c) && acc.Audit_Team_Member__c != null) {

                AccountShare accountTeamMemberShare = new AccountShare();

                accountTeamMemberShare.AccountId = acc.Id;

                accountTeamMemberShare.UserOrGroupId = acc.Audit_Team_Member__c;

                accountTeamMemberShare.AccountAccessLevel = 'Read';

                accountTeamMemberShare.OpportunityAccessLevel = 'Read';

                accountTeamMemberShare.RowCause = Schema.AccountShare.RowCause.Manual;

                accountShareList.add(accountTeamMemberShare);

 

                // Keep track of Account Ids that need updating

                accountIdsToUpdate.add(acc.Id);

            }

        }

 

        if (!accountIdsToUpdate.isEmpty()) {

            // Remove existing sharing records for the updated Accounts

            List<AccountShare> existingShares = [SELECT Id FROM AccountShare WHERE AccountId IN :accountIdsToUpdate AND RowCause = :Schema.AccountShare.RowCause.Manual];

            delete existingShares;

 

            // Insert the new sharing records for the updated Accounts

            if (!accountShareList.isEmpty()) {

                List<Database.SaveResult> accountShareListResult = Database.insert(accountShareList, false);

                // Handle errors if needed (e.g., log or notify someone)

            }

        }

    }

}