public class SD_AsynchronousApexExecution {

    @future(callout=true)
    public static void futureMethodExample() {

        //code which needs to be ran asynchronously
    }


    public static void runningQueueable() {

        //System namespace(class) is used to run the queueable
        System.enqueueJob(new SD_QueueueableClassV1('Shubham'));
    }


    public static void runningBatch() {

        //Database class is used to run batch class
        Database.executeBatch(new SD_BatchClassv1(), 99);
    }


    public static void runSchedulelable() {

        //System namespace(class) is used to schedule class, cron expression needs to be used in this case
        System.schedule('SD_SchedulableClassV1 RUN', '0 0 0 * * *', new SD_SchedulableClassV1());
    }


}