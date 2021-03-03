public class P0b {
    public static Integer nFibonacci(Integer n){
        Integer a = 0;
        Integer b = 1;
        Integer c;
        for(Integer i = 0; i<n; i++){
            c=a;
            a = b;
            b = c + b;
        }
        return a;
    }
    
    public static List<Integer> sortList( List<Integer> intList ) {
        Integer a = intList.size()-1;
        Integer temp;
        Integer temp1;
        Integer b = 0;
        while(b < a){
            b=0;
            for(Integer i = 0; i<a; i++){
                temp = intList.get(i);
                temp1 = intList.get(i+1);
                    if (temp>temp1){
                        intList.set(i, temp1);
                        intList.set(i+1, temp);
                    }else b++;
            }
        }           
        return intList;
    } 
    
    public static Integer nFactorial( Integer n) {
        Integer i = n;

        if(n==0){
            n=1;
        }

        while (i != 0){
            i--;
            if(i!=0){
            n = n*(i);
            }    
        }      
         return  n;
    }
    
    public static List<Integer> rotateLeftNTimes( List<Integer> nList, Integer n) {

        List<Integer> newList = nList;
        Integer size = nList.size()-1;

        for (Integer i=n; i!=0; i--){
            Integer temp = nList.get(0);
            for (Integer i2 = 0; i2<size; i2++) {
                    newList.set(i2, nList.get(i2+1));
                }
                newList.set(size, temp);
                nList = newList;
            } 
        return nList;
    } 
    
    
    public static Boolean bracketsAreBalanced( String s ) {
        Boolean bal = true;
        Integer length = s.length();
        List<String> cList = new List<String>();
        String test;
        cList.add('a');
           for(Integer i = 0; i<length; i++){
               test = s.substring(i, i+1);
                switch on test{
                    when '('{   
                        cList.add('(');
                    }

                    when ')'{ 
                        if (cList.get(cList.size()-1) == '('){
                            cList.remove(cList.size()-1);
                        }else bal = false;
                    }

                    when '['{  
                        cList.add('[');
                        } 

                    when ']'{ 
                        if (cList.get(cList.size()-1) == '['){
                            cList.remove(cList.size()-1);
                        }else bal = false;
                    }

                    when '{'{   
                        cList.add('{');
                    }

                    when '}'{
                        if (cList.get(cList.size()-1) == '{'){
                            cList.remove(cList.size()-1);
                       }else bal = false;
                    }
                }
            } 
        if (cList.size() > 1){
            bal = false;
        }

        return bal;
    }    
    
    public static void updateAccountSize( ) {
        List<Account> accounts = [SELECT Id, Name, NumberOfEmployees FROM Account];
        for (Account aAccount : accounts){
            if(aAccount.NumberOfEmployees >= 1 && aAccount.NumberOfEmployees <= 1000){
                aAccount.Size__c = 'small';
            }
            if(aAccount.NumberOfEmployees >= 1001 && aAccount.NumberOfEmployees <= 10000){
                aAccount.Size__c = 'medium';
            }
            if(aAccount.NumberOfEmployees >= 10001){
                aAccount.Size__c = 'large';
            }
        }
        update accounts;
    }

	public static void updateCALeads( ) {
        List<Lead> leads = [SELECT Name FROM Lead WHERE state = 'CA'];
        for (Integer i = 0; i < leads.size(); i++){
            leads[i].Status = 'Closed - Not Converted';
            leads[i].Description = 'We are no longer doing business in California.';
        }
        update leads;
    }

     public static void closePastDueOpportunities( ) {
        List<Opportunity> opportunities = [SELECT Name FROM Opportunity WHERE CloseDate < TODAY AND StageName != 'Closed Won'];
        for (Opportunity aOpportunity : opportunities){
                aOpportunity.StageName = 'Closed Lost';
        }
        update opportunities;   
		
	}
}