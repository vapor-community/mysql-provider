#if os(Linux)

import XCTest
@testable import VaporMySQLTests

XCTMain([
    testCase(VaporMySQL.allTests),
])

#endif