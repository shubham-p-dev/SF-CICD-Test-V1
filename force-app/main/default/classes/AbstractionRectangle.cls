// Concrete subclass Rectangle
public class AbstractionRectangle extends AbstractionShape {
    private Decimal length;
    private Decimal width;
    
    public AbstractionRectangle(Decimal length, Decimal width) {
        this.length = length;
        this.width = width;
    }
    
    // Implementation of abstract method
    public override Decimal calculateArea() {
        return length * width;
    }
}