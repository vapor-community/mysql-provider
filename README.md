# MySQL Provider for Vapor

Adds MySQL support to the Vapor web framework.


```swift
let mysql = try VaporMySQL.Provider(host: "localhost", user: "root", password: "", database: "birdwatcher")

let app = Application(providers: [mysql])
```

## Install and link MySQL

Follow the instructions at [qutheory/mysql](https://github.com/qutheory/mysql) to properly install and link MySQL.
