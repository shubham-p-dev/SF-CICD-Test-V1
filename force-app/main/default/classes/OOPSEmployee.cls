public class OOPSEmployee {
	
    public string name;
    public string designation;
    public Decimal experiance;
    public static String orgName;
    
    public void display() {
        System.debug('Employee Name : '+name+':: Designation : '+designation+' :: Experiance : '+
                     experiance+' :: Company : '+orgName);
        
       // orgName = 'Deloite';
    }
    
}