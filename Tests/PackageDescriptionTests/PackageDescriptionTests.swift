import XCTest
@testable import PackageDescription

final class PackageDescriptionTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PackageDescription().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
