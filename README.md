# MySQL Provider for Vapor

Adds MySQL support to the Vapor web framework.


```swift
import Vapor
import VaporMySQL

let drop = Droplet(providers: [VaporMySQL.Provider.self])
```

## Config

To build, the first place you'll want to look is the Config/ directory. In their, you should create a secrets folder and a nested `mysql.json`.

```
Config/
  - mysql.json
    secrets/
      - mysql.json
```

The secrets folder is under the gitignore and shouldn't be committed.

Here's an example `secrets/mysql.json`

```json
{
  "host": "z99a0.asdf8c8cx.us-east-1.rds.amazonaws.com",
  "user": "username",
  "password": "badpassword",
  "database": "databasename",
  "port": "3306",
  "encoding": "utf8"
}
```

You can also just set a url.

```json
{
    "url": "username:password@123.mysql.host.io"
}
```

## Install and link MySQL

Follow the instructions at [vapor/mysql](https://github.com/vapor/mysql) to properly install and link MySQL.
