public class CC {
    public static Map<String, Double> getOppRevByAccount(){
        List<AggregateResult> aggResult = [Select Account.Name acc, SUM(ExpectedRevenue)expR FROM Opportunity GROUP BY Account.Name HAVING SUM(ExpectedRevenue) > 0];
        Map<String, Double> goodOpps = new Map<String, Double>();
        for (AggregateResult agh : aggResult){
            String a = agh.get('acc').toString();
            Double b = Double.valueOf(agh.get('expR'));
            goodOpps.put(a, b);
        }
        
        //goodOpps.putAll();
        
        return goodOpps;
    } 

}