// Abstract class Shape

// Abstract class can contain both Abstract(without implementation) and Concrete(with implementation) methods
// 
// We can not create object of abstract class


public abstract class AbstractionShape {
    
    // Abstract method to calculate area
    public abstract Decimal calculateArea();
    
    
    	
    // Concrete method to describe the shape
    public void describe() {
        System.debug('This is a shape.');
    }
}