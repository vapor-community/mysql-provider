#if os(Linux)

import XCTest
@testable import VaporMySQLTestSuite

XCTMain([
    testCase(VaporMySQL.allTests),
])

#endif