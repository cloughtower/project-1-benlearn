public without sharing class CommunityController {

    public CommunityController( ) {} 
    
        public List<UndeliveredPackages_Wrapper> undeliveredWrapperList {
        get{
            if (undeliveredWrapperList == null) {
                List<Mail__c> mailList = getMail(); 
                undeliveredWrapperList = new List<UndeliveredPackages_Wrapper>();
                for (Mail__c mail : mailList) {
                    undeliveredWrapperList.add(new UndeliveredPackages_Wrapper(mail.Name, mail.Destination__r.Mailing_Address__c, mail.Weight__c, 
                                                                    mail.Height__c, mail.Width__c, mail.Value__c,
                                                                    mail.Delivery_Status__c));
                }
            }
            return undeliveredWrapperList;
        }
        set;}
        
        public List<DeliveredPackages_Wrapper> wrapperListDelivered {
        get{
            if (wrapperListDelivered == null) {
                List<Mail__c> mailList = getDeliveredMail(); 
                wrapperListDelivered = new List<DeliveredPackages_Wrapper>();
                for (Mail__c mail : mailList) {
                    wrapperListDelivered.add(new DeliveredPackages_Wrapper(mail.Name, mail.Destination__r.Mailing_Address__c, mail.Weight__c, 
                                                                    mail.Height__c, mail.Width__c, mail.Value__c,
                                                                    mail.Delivery_Status__c));
                }
            }
            return wrapperListDelivered;
        }
        set;}

    // Get the mail & put it into the list.
    public static List<Mail__c> getMail() {
        System.debug('Entered getMail() method.');
        // Get current User object
        List<User> currentUserList = [SELECT ContactId FROM User WHERE Id=:UserInfo.getUserId()];
        User currentUser = currentUserList[0];
        // Find any mail associated with the Contact that the User is associated with.
        List<Mail__c> packageList = [SELECT Name, Weight__c, Height__c, Width__c, Destination__r.Mailing_Address__c, Value__c, Delivery_Status__c 
                                     FROM Mail__c
                                     WHERE ContactReal__c = :currentUser.ContactId  
                                     AND (Delivery_Status__c = 'In Transit'
                                     OR Delivery_Status__c = 'Missing'
                                     OR Delivery_Status__c = 'Label Created')];
        System.debug('PackageList size: ' + packageList.size());
        return packageList;
    }
   

    // Get the mail & put it into the list.
    public static List<Mail__c> getDeliveredMail() {
        System.debug('Entered getDeliveredMail() method.');
        List<User> currentUserList = [SELECT ContactId FROM User WHERE Id=:UserInfo.getUserId()];
        User currentUser = currentUserList[0];
        List<Mail__c> packageListDelivered = [SELECT Name, Weight__c, Height__c, Width__c, Destination__r.Mailing_Address__c, Value__c, Delivery_Status__c 
                                     FROM Mail__c
                                     WHERE ContactReal__c = :currentUser.ContactId  
                                     AND (Delivery_Status__c = 'Delivered')];
        System.debug('PackageList size: ' + packageListDelivered.size());
        return packageListDelivered;
    }
    
    public list <Account> acc {get;set;}
    public String searchKey {get;set;}


    public void searchRecords(){
    // Escaping Single Quotes Restricts user to string strings 
        List<Account> results = Database.query('SELECT Name, Industry, Phone, Type FROM Account WHERE Name like \'%' + searchKey + '%\' Limit 10');
        acc = results ;
    }
    public void clear(){
        acc.clear();
    }
    
    public String queryTrack {get;set;} 
        public list <Mail__c> track {get;set;}

 
    public void searchTrack(){
           if (queryTrack != ''){
            List<Mail__c> trackResults = Database.query('select Name, Delivery_Status__c from mail__c where name like \'' + queryTrack + '\'');
            track = trackresults;
        } 
    }  


        
 
    

}