import PackageDescription

let package = Package(
    name: "VaporMySQL",
    dependencies: [
   		.Package(url: "../mysql-driver/", majorVersion: 0, minor: 4),
   		.Package(url: "https://github.com/vapor/vapor.git", majorVersion: 0, minor: 16),
    ]
)
