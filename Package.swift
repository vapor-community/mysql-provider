import PackageDescription

let package = Package(
    name: "VaporMySQL",
    dependencies: [
   		.Package(url: "https://github.com/qutheory/fluent-mysql.git", majorVersion: 0, minor: 2),
   		.Package(url: "https://github.com/qutheory/vapor.git", majorVersion: 0, minor: 12),
    ]
)
