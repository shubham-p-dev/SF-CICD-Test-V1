public class SOQL {
    
    public static void basicSOQL() {
        
        //AND, OR 
        List<Account> lstAccountByLike = [ SELECT Id, Name 
                                           FROM Account WHERE (Name = 'Shubham' AND Phone = '101889') 
                                           OR Fax = 'abc' ];
        
        //LIKE starting with Shubham and ending with Patil
        String varName = 'Shubham';
		List<Account> lstAccountByLikeStart = [ SELECT Id, Name FROM Account WHERE Name LIKE : varName+'%' ];
        List<Account> lstAccountByLikeEnd = [ SELECT Id, Name FROM Account WHERE Name LIKE : '%'+'Patil' ];        
        
        //ORDER BY 
        List<Account> accountsOrderByName = [ SELECT Id, Name FROM Account ORDER BY Name ];
        //ORDER BY CreatedDate newest Accounts first
        //also we can use NULLS First/NULLS LAST
        List<Account> accountsOrderByDate = [ SELECT Id, Name FROM Account ORDER BY CreatedDate DESC ];
        List<Account> accountsOrderByConCOunt = [ SELECT Id, Name FROM Account ORDER BY Contact_Count__c DESC ];
        
        //LIMIT/OFFSET(skip these no records)
        //LIMT and OFFSET is used to create pagination
        List<Account> lstAccountLmit = [ SELECT Id, Name FROM Account LIMIT 5 ];
        List<Account> lstAccountOffset = [ SELECT Id, Name FROM Account LIMIT 10 OFFSET 10 ];
        
        //DATE literals
        List<Account> lstAccCreatedToday = [ SELECT Id, Name FROM Account WHERE CreatedDate = TODAY ];
        List<Account> lstAccCreatedLast20Days = [ SELECT Id, Name FROM Account WHERE CreatedDate = LAST_N_DAYS:20 ];
        
    }
    
    
    public static void GroupBySOQL() {
        
        List<AggregateResult> lstOppGroupBy = [SELECT StageName, COUNT(Id), MAX(Amount), 
                                        MIN(Amount) FROM Opportunity GROUP BY StageName];
        
        for(AggregateResult eachObj : lstOppGroupBy) {
            /*System.debug(eachObj.get('StageName')+' -> Count '+eachObj.get('expr0')+'; MAX -> '+
                         eachObj.get('expr1')+'; MIN -> '+eachObj.get('expr2'));*/
        }
        
        
        List<AggregateResult> lstOppGroupByWithAlias = [SELECT StageName, COUNT(Id)RecCount,
                                                        SUM(Amount)AmtSum, MAX(Amount)MaxAmt, MIN(Amount)MinAmt
                                                        FROM Opportunity GROUP BY StageName];
        
        //Group By: Group By used with two fields StageName, Type
        List<AggregateResult> lstOppGroupByStageNameType = [ SELECT StageName, Type, Count(Id) RecCount,
                                                           	SUM(Amount) AmtSum, MAX(Amount) AmtMax, MIN(Amount) AmtMin
                                                            FROM Opportunity GROUP BY StageName, Type ];
        
        
        for(AggregateResult aggRes : lstOppGroupByWithAlias) {
            /*System.debug(eachObj.get('StageName')+' -> Count '+eachObj.get('expr0')+'; MAX -> '+
                         eachObj.get('expr1')+'; MIN -> '+eachObj.get('expr2'));*/        
        }
    }
    
    public static void HAVINGClauseSOQL() {
        //Having is an optionl clause used to filter result that Aggregate funtion returns
        //WHERE clause applies on single field value
        //HAVING clause applies on Aggregate value as well used along with GROUP BY clause
        
        //want to get opportunity group where SUM(Amnount) greater than 395000
        List<AggregateResult> oppGroupByStageNameWithHighAmt = [ SELECT StageName, SUM(Amount) AmtSum FROM 
                                                                Opportunity GROUP BY StageName HAVING 
                                                                SUM(Amount) >= 395000 ];
        
        System.debug('oppGroupByStageNameWithHighAmt --> '+oppGroupByStageNameWithHighAmt);
    }
    
	
    public static void parentChildSOQL() {
        
        //PARENT-CHILD Standard SOQL
        List<Account> lstAccWithConOpp = [	SELECT Id, Name, 
                                          	(SELECT Id, Name FROM Contacts), 
                                          	(SELECT Id, Name FROM Opportunities) 
                                          	FROM Account ];
        
        //PARENT-CHILD Custom
        List<Room__c> roomList = [ SELECT Id, (SELECT Id FROM Bookings__r) FROM Room__c ];
    }
    
    
    public static void childParentSOQL() {
        
        //CHILD-PARENT SOQL standard
        List<Contact> lstContact = [ SELECT Id, Name, Account.Name FROM Contact ];
        
        //CHILD-PARENT SOQL standard
        List<Booking__c> lstBooking = [ SELECT Id, Name, Room_No__r.Name FROM Booking__c ];
        
    }
 	   
    
    
    public static void runComplexQuery() {
        
        List<Contact> lstContactAccCases = [ SELECT Account.Name, Account.Rating, Name, Department, Title, 
                                            (SELECT CaseNumber, Subject FROM Cases) 
                                            FROM Contact ORDER BY Name ];
    }
    
    
    public static void aggregateFunctionsSOQL() {
        
        //Count - Count no of records present in an Object
        Integer noOfAccount = [SELECT Count() FROM Account];
        system.debug('noOfAccount '+noOfAccount);
        
        
        //Count(Field_Name) - Count records which having non-null value for passed field
        List<AggregateResult> lstAggregateResults = [SELECT Count(Name), Count(Phone), Count(Title) FROM Contact];
        
        system.debug('lstAggregateResults '+lstAggregateResults);
        
        //Sum, Min, Max numeric values
        List<AggregateResult> sumMinMaxAmountValueOpp = [SELECT SUM(Amount__c)SumAmt, MIN(Amount__c), 
                                                         MAX(Amount__c), AVG(Amount__C) FROM Contact];
        
        system.debug('sumMinMaxAmountValueOpp '+sumMinMaxAmountValueOpp);        
    }
    
    
}