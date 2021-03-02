public without sharing class UndeliveredPackages_CC {
    
    public List<UndeliveredPackages_Wrapper> wrapperList {
        get{
            if (wrapperList == null) {
                List<Mail__c> mailList = getMail(); 
                wrapperList = new List<UndeliveredPackages_Wrapper>();
                for (Mail__c mail : mailList) {
                    wrapperList.add(new UndeliveredPackages_Wrapper(mail.Name, mail.Address__c, mail.Weight__c, 
                                                                    mail.Height__c, mail.Width__c, mail.Insurance_Amount__c,
                                                                    mail.Delivery_Status__c));
                }
            }
            return wrapperList;
        }
        set;}

    // Get the mail & put it into the list.
    public static List<Mail__c> getMail() {
        System.debug('Entered getMail() method.');
        // Get current User object
        List<User> currentUserList = [SELECT ContactId FROM User WHERE Id=:UserInfo.getUserId()];
        User currentUser = currentUserList[0];
        // Find any mail associated with the Contact that the User is associated with.
        List<Mail__c> packageList = [SELECT Name, Weight__c, Height__c, Width__c, Address__c, Insurance_Amount__c, Delivery_Status__c 
                                     FROM Mail__c
                                     WHERE Inhabitant__r.Contact__c = :currentUser.ContactId  
                                     AND (Delivery_Status__c = 'Not Delivered'
                                     OR Delivery_Status__c = 'Missing')];
        System.debug('PackageList size: ' + packageList.size());
        return packageList;
    }
}