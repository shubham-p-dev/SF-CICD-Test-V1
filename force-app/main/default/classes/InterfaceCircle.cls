// Class Circle implementing Drawable
public class InterfaceCircle implements InterfaceDemo {
    private Decimal radius;
    
    public InterfaceCircle(Decimal radius) {
        this.radius = radius;
    }
    
    // Implementation of draw method
    public List<String> draw() {
        System.debug('Drawing a circle with radius ' + radius);
        return null;
    }
    
    public void ShubhamMethod() {
        
    }
    
}