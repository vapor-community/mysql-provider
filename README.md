# MySQL Provider for Vapor

Adds MySQL support to the Vapor web framework.


```swift
let mysql = try VaporMySQL.Provider(host: "localhost", user: "root", password: "", database: "birdwatcher")

let app = Application(providers: [mysql])
```
