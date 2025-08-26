public class SD_BatchClassv1 implements Database.Batchable<Sobject>, Database.Stateful, Database.AllowsCallouts {

    public SD_BatchClassv1() {

    }


    public Database.queryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator('SELECT Id FROM Account');
    }


    public void execute(Database.BatchableContext bc, List<SObject> listRecords) {


    }


    public void finish(Database.BatchableContext bc) {


    }

}