import XCTest
import Vapor
@testable import MySQLProvider

class VaporMySQL: XCTestCase {
    func testHappyPath() throws {
        let config = try Config(node: [
            "fluent": [
                "driver": "mysql",
                "maxConnections": 1337
            ],
            "mysql": [
                "hostname": "127.0.0.1",
                "user": "ubuntu",
                "password": "",
                "database": "circle_test"
            ]
        ])
        let drop = try Droplet(config: config)
        XCTAssert(drop.database == nil)

        try drop.addProvider(Provider.self)
        XCTAssert(drop.database != nil)

        XCTAssertEqual(drop.database?.threadConnectionPool.maxConnections, 1337)

        guard let result = try drop.database?.raw("SELECT @@version") else {
            XCTFail("No result")
            return
        }

        XCTAssert(result[0, "@@version"]?.string?.contains("5.") == true)
    }

    func testDifferentDriver() throws {
        let config = try Config(node: [
            "fluent": [
                "driver": "memory"
            ]
        ])
        let drop = try Droplet(config: config)
        XCTAssert(drop.database == nil)

        // we're still adding the VaporMySQL provider,
        // but nothing should fail since we are specifying "memory"
        try drop.addProvider(Provider.self)
        XCTAssert(drop.database == nil)
    }

    func testMissingConfigFails() throws {
        let config = try Config(node: [
            "fluent": [
                "driver": "mysql"
            ]
        ])
        let drop = try Droplet(config: config)
        XCTAssert(drop.database == nil)

        do {
            try drop.addProvider(Provider.self)
            XCTFail("Should have failed.")
        } catch ConfigError.missingFile(let file) {
            XCTAssert(file == "mysql")
        } catch {
            XCTFail("Wrong error: \(error)")
        }
    }

    static let allTests = [
        ("testHappyPath", testHappyPath),
        ("testDifferentDriver", testDifferentDriver),
        ("testMissingConfigFails", testMissingConfigFails)
    ]
}
