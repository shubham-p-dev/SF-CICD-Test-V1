public class SD_QueueueableClassV1 implements Queueable, Database.AllowsCallouts {

    private String someVariable;


    public SD_QueueueableClassV1(String someVariable) {
        
        System.debug('SD_QueueueableClassV1 -->');

        this.someVariable = someVariable;
    }

    
    public void execute(QueueableContext qc) {

        System.debug('SD_QueueueableClassV1 execute -->');
        
        System.debug('SD_QueueueableClassV1 this.someVariable -->'+this.someVariable);
        System.debug('SD_QueueueableClassV1 someVariable -->'+someVariable);
    }

}