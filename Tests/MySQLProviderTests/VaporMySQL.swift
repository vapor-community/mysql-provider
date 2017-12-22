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
                "user": "root",
                "password": "",
                "database": "test"
            ]
        ])
        
        try config.addProvider(Provider.self)
        let drop = try Droplet(config)
        let database = try drop.assertDatabase()

        XCTAssertEqual(database.threadConnectionPool.maxConnections, 1337)
        let result = try database.raw("SELECT @@version")

        XCTAssert(result[0, "@@version"]?.string?.contains("5.") == true)
    }

    func testDifferentDriver() throws {
        var config = Config([:])
        try config.set("fluent.driver", "memory")
        try config.addProvider(Provider.self)
        let drop = try Droplet(config: config)
        
        // we're still adding the VaporMySQL provider,
        // but nothing should fail since we are specifying "memory"
        _ = try drop.assertDatabase()
    }

    func testMissingConfigFails() throws {
        let config = try Config(node: [
            "fluent": [
                "driver": "mysql"
            ]
        ])
        try config.addProvider(Provider.self)

        do {
            _ = try Droplet(config)
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
