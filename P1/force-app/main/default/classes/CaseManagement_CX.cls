public without sharing class CaseManagement_CX {

    public List<Case> caseList {
        get {
            if (caseList == null) {
                caseList = getCases();
            }
            return caseList;
        }
        set;
    }

    public String recordId {get; set;}
    public String subject {get; set;}
    public String description {get; set;}
    public String reason {get; set;}
    //public String email {get; set;}
    //public String phone {get; set;}


    public ApexPages.StandardController standardController;

    public static List<Case> getCases() {
        List<User> currentUserList = [SELECT ContactId FROM User WHERE Id=:UserInfo.getUserId()];
        User currentUser = currentUserList[0];
        return [SELECT Id, CaseNumber, ContactId, Description, Status, Subject, Reason
                FROM Case WHERE ContactId = :currentUser.ContactId];
    }

    public CaseManagement_CX(ApexPages.StandardController stdController) {
        standardController = stdController;
    }

    public PageReference save() {
        standardController.save();
        return ApexPages.currentPage();
    }

    public PageReference back() {
        return new PageReference('https://very-clueless-developer-edition.na150.force.com/s/contactsupport');
    }

    public PageReference showDetail() {
        return new PageReference('https://very-clueless-developer-edition.na150.force.com/contactsupport/CaseDetail_Page?id=' + recordId);
    }

    public PageReference newCase() {
        return new PageReference('https://very-clueless-developer-edition.na150.force.com/CaseCreation_Page');
        //return Page.CaseCreation_Page;
    }
    
    public PageReference submitCase() {
        User currentUser = [SELECT Id, ContactId FROM User WHERE User.Username = :UserInfo.getUserName()
                            LIMIT 1];
        Case newCase = new Case(Status='New', Origin='Web', ContactId=currentUser.ContactId,
                                Description=description, Subject=subject, Reason=reason);
        insert newCase;
        return new PageReference('https://very-clueless-developer-edition.na150.force.com/s/contactsupport');
    }
    

}