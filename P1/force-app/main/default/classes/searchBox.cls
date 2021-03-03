public class searchBox {
    public list <Mail__c> track {get;set;}
    public String searchKey {get;set;}
    public searchBox( ) {} 
    public void search(){
           if (searchKey != ''){
            string searchquery='select Name, Delivery_Status__c from mail__c where name like \'' + searchKey + '\'';
            track = Database.query(searchquery);
        } 
    }
}