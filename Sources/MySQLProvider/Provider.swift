import URI
import Vapor
import Fluent

public final class Provider: Vapor.Provider {
    /// MySQL database driver created by the provider.
    public let driver: MySQLDriver

    /// Hold onto database until provider.boot is called.
    private let database: Database

    /// Creates a MySQL provider from a `mysql.json`
    /// config file.
    ///
    /// The file should contain similar JSON:
    ///
    ///     {
    ///         "host": "127.0.0.1",
    ///         "user": "root",
    ///         "password": "",
    ///         "database": "test",
    ///         "port": 3306, // optional
    ///         "flag": 0, // optional
    ///         "encoding": "utf8" // optional
    ///     }
    ///
    /// Optionally include a url instead:
    ///
    ///     {
    ///         "url": "mysql://user:pass@host:3306/database"
    ///     }
    public convenience init(config: Config) throws {
        guard let mysql = config["mysql"]?.object else {
            throw ConfigError.missingFile("mysql")
        }

        let flag = mysql["flag"]?.uint
        let encoding = mysql["encoding"]?.string

        if let url = mysql["url"]?.string {
            try self.init(url: url, flag: flag, encoding: encoding)
        } else {
            guard let host = mysql["host"]?.string else {
                throw ConfigError.missing(key: ["host"], file: "mysql", desiredType: String.self)
            }

            guard let user = mysql["user"]?.string else {
                throw ConfigError.missing(key: ["user"], file: "mysql", desiredType: String.self)
            }

            guard let password = mysql["password"]?.string else {
                throw ConfigError.missing(key: ["password"], file: "mysql", desiredType: String.self)
            }

            guard let database = mysql["database"]?.string else {
                throw ConfigError.missing(key: ["database"], file: "mysql", desiredType: String.self)
            }

            let port = mysql["port"]?.uint

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
    }

    /// See Provider.init(host: String, ...)
    public convenience init(url: String, flag: UInt?, encoding: String?) throws {
        let uri = try URI(url)
        guard
            let user = uri.userInfo?.username,
            let pass = uri.userInfo?.info
        else {
            throw ConfigError.missing(key: ["url(userInfo)"], file: "mysql", desiredType: URI.self)
        }

        let db = uri.path
            .characters
            .split(separator: "/")
            .map { String($0) }
            .joined(separator: "")

        try self.init(
            host: uri.hostname,
            user: user,
            password: pass,
            database: db,
            port: uri.port.flatMap { UInt($0) },
            flag: flag,
            encoding: encoding
        )
    }

    /// Attempts to establish a connection to a MySQL database
    /// engine running on host.
    ///
    /// - parameter host: May be either a host name or an IP address.
    ///         If host is the string "localhost", a connection to the local host is assumed.
    /// - parameter user: The user's MySQL login ID.
    /// - parameter password: Password for user.
    /// - parameter database: Database name.
    ///         The connection sets the default database to this value.
    /// - parameter port: If port is not 0, the value is used as
    ///         the port number for the TCP/IP connection.
    /// - parameter socket: If socket is not NULL,
    ///         the string specifies the socket or named pipe to use.
    /// - parameter flag: Usually 0, but can be set to a combination of the
    ///         flags at http://dev.mysql.com/doc/refman/5.7/en/mysql-real-connect.html
    /// - parameter encoding: Usually "utf8", but something like "utf8mb4" may be
    ///         used, since "utf8" does not fully implement the UTF8 standard and does
    ///         not support Unicode.
    ///
    /// - throws: `Error.connection(String)` if the call to
    ///         `mysql_real_connect()` fails.
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
        self.database = Database(driver)
    }

    /// See Vapor.Provider.boot
    public func boot(_ drop: Droplet) {
        if let existing = drop.database {
            drop.log.debug("VaporMySQL overriding existing database: \(type(of: existing))")
        }
        drop.database = database
    }

    /// See Vapor.Provider.afterInit
    public func afterInit(_ drop: Droplet) {

    }

    /// See Vapor.Provider.beforeRun
    public func beforeRun(_ drop: Droplet) {

    }
}
