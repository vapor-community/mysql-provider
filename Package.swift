import PackageDescription

let package = Package(
    name: "VaporMySQL",
    dependencies: [
        // MySQL driver for Fluent
   		.Package(url: "https://github.com/vapor/mysql-driver.git", Version(2,0,0, prereleaseIdentifiers: ["alpha"])),
   		// A provider for including Fluent in Vapor applications
        .Package(url: "https://github.com/vapor/fluent-provider.git", majorVersion: 0),
   		// A web framework and server for Swift that works on macOS and Ubuntu.
   		.Package(url: "https://github.com/vapor/vapor.git", Version(2,0,0, prereleaseIdentifiers: ["alpha"])),
    ]
)
