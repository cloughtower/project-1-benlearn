@isTest
public inherited sharing class UndeliveredPackages_DataFactory {

    @isTest
    public static void makeData() {

        // Create data for multiple users.

        List<User> userList = [SELECT Id, Name, ContactId FROM User
                               WHERE Name='Pepper *Stark'];
        User testUser = userList[0];
        
        List<User> userList2 = [SELECT Id, Name, ContactId FROM User
                                WHERE Name='Edna Frank'];
        User user2 = userList2[0];

        // Create addresses
        List<Address__c> addressList = new List<Address__c>();
        addressList.add(new Address__c(Street__c='100 Test St', City__c='Test', 
                                       State__c='NY', Zip_Code__c='12345'));
        addressList.add(new Address__c(Street__c='100 First St', City__c='Nowhere', 
                                       State__c='TX', Zip_Code__c='54321'));
        addressList.add(new Address__c(Street__c='200 AltTest St', City__c='Test', 
                                       State__c='NY', Zip_Code__c='12345'));

        insert addressList;

        // Create Contacts
        List<Contact> contactList = new List<Contact>();
        contactList.add(new Contact(FirstName='Pepper', LastName='*Stark', Salutation='Mrs.', MobilePhone='1112223333'));
        contactList.add(new Contact(FirstName='Edna', LastName='Frank', Salutation='Ms.', MobilePhone='2223334444'));

        insert contactList;

        // Create Inhabitants
        List<Inhabitant__c> inhabitantList = new List<Inhabitant__c>();
        inhabitantList.add(new Inhabitant__c(Contact__c=contactList[0].Id, Address__c=addressList[0].Id));
        inhabitantList.add(new Inhabitant__c(Contact__c=contactList[1].Id, Address__c=addressList[1].Id));
        inhabitantList.add(new Inhabitant__c(Contact__c=contactList[0].Id, Address__c=addressList[2].Id));

        insert inhabitantList;

        // Create undelivered Mail
        List<Mail__c> mailList = new List<Mail__c>();

        // Create mail for the first user with different delivery statuses.
        mailList.add(new Mail__c(Height__c=1, Weight__c=1, Width__c=1, 
                                 Delivery_Status__c='Not Delivered', Inhabitant__c=inhabitantList[0].Id));
        mailList.add(new Mail__c(Height__c=2, Weight__c=2, Width__c=2, 
                                 Delivery_Status__c='Missing', Inhabitant__c=inhabitantList[0].Id));
        mailList.add(new Mail__c(Height__c=3, Weight__c=3, Width__c=3, 
                                 Delivery_Status__c='Delivered', Inhabitant__c=inhabitantList[0].Id));

        // Create mail for the first user with a different Inhabitant value (i.e. a different address).
        mailList.add(new Mail__c(Height__c=1, Weight__c=1, Width__c=1, 
                                 Delivery_Status__c='Not Delivered', Inhabitant__c=inhabitantList[2].Id));

        // Create mail for the second user.
        mailList.add(new Mail__c(Height__c=4, Weight__c=1, Width__c=3, 
                     Delivery_Status__c='Not Delivered', Inhabitant__c=inhabitantList[1].Id));
        mailList.add(new Mail__c(Height__c=2, Weight__c=2, Width__c=2, 
                     Delivery_Status__c='Missing', Inhabitant__c=inhabitantList[1].Id));
        mailList.add(new Mail__c(Height__c=6, Weight__c=3, Width__c=10, 
                     Delivery_Status__c='Delivered', Inhabitant__c=inhabitantList[1].Id));

        // For the current version of the code, there should be 7 pieces of mail total.
        // Of those, only two should be visible for the user Pepper *Stark. 
        // Update: with 'Missing' included, 3 packages should be visible.
        insert mailList;

        // Create Cases
        List<Case> caseList = new List<Case>();
        caseList.add(new Case(Status='New', Origin='Email', ContactId=contactList[1].Id, Description='Belongs to Edna Frank'));
        caseList.add(new Case(Status='New', Origin='Email', ContactId=contactList[0].Id, Description='Belongs to Pepper *Stark'));
        caseList.add(new Case(Status='New', Origin='Email', ContactId=contactList[0].Id, Description='Also belongs to Pepper *Stark'));
        
        insert caseList;
    }

}
