public without sharing class UndeliveredPackages_CC {
    
    public List<UndeliveredPackages_Wrapper> wrapperList {
        get{
            if (wrapperList == null) {
                List<Mail__c> mailList = getMail(UserInfo.getName()); //.getUserId
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
    public static List<Mail__c> getMail(String nameOfUser) {
        System.debug('Entered getMail() method.');
        System.debug('User\'s name: ' + nameOfUser);
        List<Mail__c> packageList = [SELECT Name, Weight__c, Height__c, Width__c, Address__c, Insurance_Amount__c, Delivery_Status__c 
                                     FROM Mail__c
                                     WHERE Inhabitant__r.Contact__r.Name = :nameOfUser  
                                     AND (Delivery_Status__c = 'Not Delivered'
                                     OR Delivery_Status__c = 'Missing')];
        System.debug('PackageList size: ' + packageList.size());
        return packageList;
    }

}
