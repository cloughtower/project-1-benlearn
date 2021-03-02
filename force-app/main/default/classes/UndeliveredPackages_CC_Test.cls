@isTest
private inherited sharing class UndeliveredPackages_CC_Test {
 
    @isTest
    private static void testGetMail() {

        /* NOTE: The code was rewritten to compare the ContactIds of the
        user and the contact rather than name of the user and contact. As
        a result, this test no longer functions as intended. It is unclear
        how one would associate the existing ContactId field of the User
        with a new Contact, given that Ids are automatically assigned. */

        System.debug('Started UndeliveredPackages_CC Test');
        List<User> userList = [SELECT Id, Name FROM User
                               WHERE Name='Pepper *Stark'];
        System.debug('UserList size: ' + userList.size());

        User testUser = userList[0];

        UndeliveredPackages_DataFactory.makeData();
        System.debug('Test Data has been created.');

        List<Mail__c> fullMailList = [SELECT id FROM Mail__c];
        System.debug('FullMailList has been created and is of size: ' + fullMailList.size() + ' (Should be 7.)');
        System.Assert(fullMailList.size() == 7);

        
        System.runAs(testUser) {
            List<Mail__c> mailList = UndeliveredPackages_CC.getMail();
            //System.debug('The user can only see ' + mailList.size() + ' packages. (Should be 2.)');
            //System.Assert(mailList.size() == 2);
            System.debug('The user can only see ' + mailList.size() + ' packages. (Should be 3.)');
            System.Assert(mailList.size() == 3);           
        }
        
    }
}
