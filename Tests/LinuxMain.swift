#if os(Linux)

import XCTest
@testable import MySQLProviderTests

XCTMain([
    testCase(VaporMySQL.allTests),
])

#endif