public class SD_QueueueableClassV1 implements Queueable {


    public SD_QueueueableClassV1() {
        System.debug('SD_QueueueableClassV1 -->');
    }

    
    public void execute(QueueableContext qc) {

        System.debug('SD_QueueueableClassV1 execute -->');
    }


}