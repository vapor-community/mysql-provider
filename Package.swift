import PackageDescription

let package = Package(
    name: "VaporMySQL",
    dependencies: [
   		.Package(url: "https://github.com/vapor/mysql-driver.git", majorVersion: 0, minor: 6),
   		.Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0, minor: 18),
    ]
)
