@isTest
public class CalculatorClassTest {
    @isTest
    static void testAddition() {
        // Create an instance of the CalculatorClass
        CalculatorClass calculator = new CalculatorClass();
        
        // Test addition
        Integer result = calculator.add(2, 3);
        System.assertEquals(5, result, 'Addition result is incorrect');
    }
    
    @isTest
    static void testSubtraction() {
        // Create an instance of the CalculatorClass
        CalculatorClass calculator = new CalculatorClass();
        
        // Test subtraction
        Integer result = calculator.subtract(5, 3);
        System.assertEquals(2, result, 'Subtraction result is incorrect');
    }
    
    // Add more test methods for other operations if needed
}