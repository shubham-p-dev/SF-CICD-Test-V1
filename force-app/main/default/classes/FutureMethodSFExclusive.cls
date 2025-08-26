public class FutureMethodSFExclusive implements Queueable {
    
    public FutureMethodSFExclusive() {
        takeShower();
        doBreakfast();
        
        List<Account> allList = new List<Account>();
        for(integer i=1; i <= 10; i++) {
            Account acc = new Account(name='shubham '+i);
            allList.add(acc);
        }
        
		String accListJson = JSON.serialize(allList);
        servicingCar(accListJson);
        
        movieWithGF();
    }
    
    public static void takeShower(){
        system.debug('#1 Taking shower');
    }
    
    public static void doBreakfast(){
        system.debug('#2 Doing breakfast');
    }    
    
    @future
    public static void servicingCar(String accWrapper){
        
        system.debug('String account '+accWrapper);
        
        List<Account> lstAccounts = (List<Account>) JSON.deserialize(accWrapper, List<Account>.class);
        system.debug('each account obj '+lstAccounts[0]);   
        
//        for(Account eachAcc : (List<Account>) JSON.deserialize(accWrapper, List<Account>.class)){
//            system.debug('each account obj '+eachAcc);   
//        }
                
        system.debug('#3 at car servicing center');
    }
    
    public static void movieWithGF(){
        system.debug('#4 movie with gf');
    }
    
    
    public void execute(QueueableContext qc) {
        system.debug('#5 sleep');
    }
    
}