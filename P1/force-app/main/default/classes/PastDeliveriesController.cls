public inherited sharing class PastDeliveriesController {
    public List<Mail__C> mailList{get;set;}

    public PastDeliveriesController() {
        
        mailList = [SELECT name, status__c  FROM Mail__c Where Status__c = 'Delivered'];
    
    }
}
