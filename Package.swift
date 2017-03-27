import PackageDescription

let beta = Version(2,0,0, prereleaseIdentifiers: ["beta"])

let package = Package(
    name: "MySQLProvider",
    dependencies: [
        // MySQL driver for Fluent
        .Package(url: "https://github.com/vapor/mysql-driver.git", beta),
        // A provider for including Fluent in Vapor applications
        .Package(url: "https://github.com/vapor/fluent-provider.git", Version(1,0,0, prereleaseIdentifiers: ["beta"])),
        // A web framework and server for Swift that works on macOS and Ubuntu.
        .Package(url: "https://github.com/vapor/vapor.git", beta),
    ]
)
