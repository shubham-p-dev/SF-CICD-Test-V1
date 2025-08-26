public class OOPS {
    
    
//==========================================================================================================================
    
    
    // Encapsulation
    // Bundling of variables and methods is called Encapsulation
    // Here the student class bundles all variables/properties and methods/behaviors
    // Wrapper class is perfect example of Encapsulation as it wrapps the variables and methods. 
    // and can be used as per use case.
    public class student {        
        String Name;
        Integer Age;
        Integer RollNumber;
        
        void markAttendance() {
            System.debug('Marking Attendance');
        }
        
        void payFee() {
            System.debug('Paying fees');
        }
    }
 
    
//==========================================================================================================================
    
    
    // Abstraction
   
    // 1) Abstract Class
    // 2) Interface
   
    // Eg. If any class implements an Interface we must need to write the defination of all the methods which are
    // declared in that Interface.
    // best examples of interface in apex are Batch, Queueable and Schedualble
    // so basically which ever class implements the given interface we will force to use the methods predefined 
    // in that interface
    /*public class inheritanceBatchDemo implements Database.batchable<sObject> {
        
        public Database.queryLocator start(Database.BatchableContext bc) {
            return null;
        }
        
        public void execute(Database.BatchableContext bc, List<sObject> scope) {
            
        }
        
        public void finish(Database.BatchableContext bc) {
            
        }
    }*/
    
    
//==========================================================================================================================

    
	// Inheritance



//==========================================================================================================================

	
    // Polymorphism
    // Method Overloading is compile-time polymorphism: multiple methods with the same name 
    // but different parameter lists within the same class.
    // Method Overriding is run-time polymorphism: a subclass provides a specific implementation of a method 
    // that is already defined in its superclass.
    
    // overloading
    void send(String text) {
    }
    
    void send(Blob singleImage) {
    }

    void send(List<Blob> lstImages) {
    }
    
	
	// overriding
    public class Animal {
        public String makeSound() {
            return 'Some generic sound';
        }
    }
    /*
    public class Dog extends Animal {
        public override String makeSound() {
            return 'Bark';
        }
    }

    // Usage
    Animal myDog = new Dog();
    System.debug(myDog.makeSound()); // Output: Bark
    */
}