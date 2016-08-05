# MySQL Provider for Vapor

Adds MySQL support to the Vapor web framework.


```swift
import Vapor
import VaporMySQL

let drop = Droplet(providers: [VaporMySQL.Provider.self])
```

## Install and link MySQL

Follow the instructions at [qutheory/mysql](https://github.com/qutheory/mysql) to properly install and link MySQL.
