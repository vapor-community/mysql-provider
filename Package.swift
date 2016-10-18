import PackageDescription

let package = Package(
    name: "VaporMySQL",
    dependencies: [
   		.Package(url: "https://github.com/vapor/mysql-driver.git", majorVersion: 1),
   		.Package(url: "https://github.com/vapor/vapor.git", versions: Version(1,1,0)..<Vapor(2,0,0)),
    ]
)
