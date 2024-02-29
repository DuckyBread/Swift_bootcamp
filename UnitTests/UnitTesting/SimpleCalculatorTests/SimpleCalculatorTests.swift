import XCTest

final class SimpleCalculatorTests: XCTestCase {

    var calc: SimpleCalculator!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        calc = SimpleCalculator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        calc = nil
        try super.tearDownWithError()
    }

    func testFibonacci() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        XCTAssertEqual(calc.fibonacci(n: 4), 2)
    }

    func testFahrenheit() throws {
        XCTAssertEqual(calc.fahrenheit(celcius: 10), -14.0)
    }
    func testIsEven() throws {
        XCTAssertTrue(calc.isEven(num: 2))
        XCTAssertFalse(calc.isEven(num:3))
    }
    
    func testGetAvg() throws {
        XCTAssertNil(calc.getAvg(numbers: []))
        
        XCTAssertNotNil(calc.getAvg(numbers: [1, 2, 3, 4]))
        
        XCTAssertEqual(calc.getAvg(numbers: [1, 2, 3, 4])!, 2.5)
    }
    
    func testCircleArea() throws {
        XCTAssertEqual(calc.circleArea(radius: 5.0), 78.5)
    }
}
