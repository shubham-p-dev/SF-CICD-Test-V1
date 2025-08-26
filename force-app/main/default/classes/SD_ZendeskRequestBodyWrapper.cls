public with sharing class SD_ZendeskRequestBodyWrapper {

    public ticket ticket;

    public SD_ZendeskRequestBodyWrapper() {
        this.ticket = new ticket();
    }

    public class ticket {
        public comment comment;
        public String priority;
        public String subject;
        public requester requester;

        public ticket() {
            this.comment = new comment();
            this.requester = new requester();
        }
    }

    public class comment {
        public String body;
    }

    public class requester {
        public Integer locale_id;
        public String name;
        public String email;
    }
}
