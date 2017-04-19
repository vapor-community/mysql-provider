import URI
import Vapor
import Fluent
import MySQLDriver

extension MySQLDriver.Driver: ConfigInitializable {
    /// Creates a MySQLDriver from a `mysql.json`
    /// config file.
    ///
    /// The file should contain similar JSON:
    ///
    ///     {
    ///         "hostname": "127.0.0.1",
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
            let masterHostname: String
            if let master = mysql["hostname"]?.string {
                masterHostname = master
            } else if let master = mysql["master"]?.string {
                masterHostname = master
            } else {
                throw ConfigError.missing(key: ["hostname"], file: "mysql", desiredType: String.self)
            }
            
            let readReplicaHostnames: [String]
            if let array = mysql["readReplicas"]?.array?.flatMap({ $0.string }) {
                readReplicaHostnames = array
            } else if let string = mysql["readReplicas"]?.string {
                readReplicaHostnames = string.commaSeparatedArray()
            } else {
                readReplicaHostnames = []
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
                masterHostname: masterHostname,
                readReplicaHostnames: readReplicaHostnames,
                user: user,
                password: password,
                database: database,
                port: port ?? 3306,
                flag: flag ?? 0,
                encoding: encoding ?? "utf8"
            )
        }
    }

    /// See MySQLDriver.init(host: String, ...)
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
            masterHostname: uri.hostname,
            readReplicaHostnames: [],
            user: user,
            password: pass,
            database: db,
            port: uri.port.flatMap { UInt($0) } ?? 3306,
            flag: flag ?? 0,
            encoding: encoding ?? "utf8"
        )
    }
}
