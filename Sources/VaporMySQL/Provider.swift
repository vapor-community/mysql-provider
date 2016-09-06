import Vapor
import Fluent
import FluentMySQL

public typealias MySQLDriver = FluentMySQL.MySQLDriver

public final class Provider: Vapor.Provider {
    public let provided: Providable

    public enum Error: Swift.Error {
        case noMySQLConfig
        case missingConfig(String)
    }

    /**
        MySQL database driver created by the provider.
    */
    public let driver: MySQLDriver

    /**
        Creates a MySQL provider from a `mysql.json`
        config file.
     
        The file should contain similar JSON:
        
            {
                "host": "127.0.0.1",
                "user": "root",
                "password": "",
                "database": "test",
                "port": 3306, // optional
                "flag": 0, // optional
                "encoding": "utf8" // optional
            }
    */
    public convenience init(config: Config) throws {
        guard let mysql = config["mysql"]?.object else {
            throw Error.noMySQLConfig
        }

        guard let host = mysql["host"]?.string else {
            throw Error.missingConfig("host")
        }

        guard let user = mysql["user"]?.string else {
            throw Error.missingConfig("user")
        }

        guard let password = mysql["password"]?.string else {
            throw Error.missingConfig("password")
        }

        guard let database = mysql["database"]?.string else {
            throw Error.missingConfig("database")
        }

        let port = mysql["port"]?.uint
        let flag = mysql["flag"]?.uint
        
        guard let encoding = mysql["encoding"]?.string else {
            throw Error.missingConfig("encoding")
        }

        try self.init(
            host: host,
            user: user,
            password: password,
            database: database,
            port: port,
            flag: flag,
            encoding: encoding
        )
    }

    /**
        Attempts to establish a connection to a MySQL database
        engine running on host.

        - parameter host: May be either a host name or an IP address.
        If host is the string "localhost", a connection to the local host is assumed.
        - parameter user: The user's MySQL login ID.
        - parameter password: Password for user.
        - parameter database: Database name.
        The connection sets the default database to this value.
        - parameter port: If port is not 0, the value is used as
        the port number for the TCP/IP connection.
        - parameter socket: If socket is not NULL,
        the string specifies the socket or named pipe to use.
        - parameter flag: Usually 0, but can be set to a combination of the
        flags at http://dev.mysql.com/doc/refman/5.7/en/mysql-real-connect.html
         - parameter encoding: Usually "utf8", but something like "utf8mb4" may be
             used, since "utf8" does not fully implement the UTF8 standard and does
             not support Unicode.


        - throws: `Error.connection(String)` if the call to
        `mysql_real_connect()` fails.
    */
    public init(
        host: String,
        user: String,
        password: String,
        database: String,
        port: UInt? = nil,
        flag: UInt? = nil,
        encoding: String? = nil
    ) throws {
        let driver = try MySQLDriver(
            host: host,
            user: user,
            password: password,
            database: database,
            port: port ?? 3306,
            flag: flag ?? 0,
            encoding: encoding ?? "utf8"
        )

        self.driver = driver

        let db = Database(driver)
        provided = Providable(database: db)
    }

    /**
        Called after the Droplet has completed
        initialization and all provided items
        have been accepted.
    */
    public func afterInit(_ drop: Droplet) {

    }

    /**
        Called before the Droplet begins serving
        which is @noreturn.
    */
    public func beforeServe(_ drop: Droplet) {

    }
}
