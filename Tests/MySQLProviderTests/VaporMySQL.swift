import XCTest
@testable import MySQLProvider

class VaporMySQL: XCTestCase {
    static let allTests = [
        ("testBasic", testBasic)
    ]

    func testBasic() {
        XCTAssertEqual(2 + 2, 4)
    }
}
