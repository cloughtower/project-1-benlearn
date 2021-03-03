public class Feb22CodingChallenge_CC {

    public List<Feb22CodingChallenge_Wrapper> wrapList {get; set;}

    public List<Feb22CodingChallenge_Wrapper> getOppRevByAccount(){

        wrapList = new List<Feb22CodingChallenge_Wrapper>();

        List<AggregateResult> ars = [SELECT SUM(ExpectedRevenue) expR, Account.Name name FROM Opportunity GROUP BY Account.Name HAVING SUM(ExpectedRevenue) > 0];

        for(AggregateResult ar : ars) {
            wrapList.add(new Feb22CodingChallenge_Wrapper(ar.get('name').toString(), Double.valueOf(ar.get('expR'))));
        }

        return wrapList;
        
    }
    
    public Feb22CodingChallenge_CC(){
        getOppRevByAccount();
    }
}