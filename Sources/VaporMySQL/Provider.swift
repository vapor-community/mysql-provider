import Vapor
import FluentMySQL

public typealias MySQLDriver = FluentMySQL.MySQLDriver

public final class Provider: Vapor.Provider {
    /**
        MySQL database driver created by the provider.
    */
    public let driver: MySQLDriver

    /**
        MySQL database created by the provider.
    */
    public let database: DatabaseDriver?

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


        - throws: `Error.connection(String)` if the call to
        `mysql_real_connect()` fails.
    */
    public init(
        host: String,
        user: String,
        password: String,
        database: String,
        port: UInt = 3306,
        flag: UInt = 0
    ) throws {
        let driver = try MySQLDriver(
            host: host,
            user: user,
            password: password,
            database: database,
            port: port,
            flag: flag
        )

        self.driver = driver
        self.database = driver
    }

    public func boot(with application: Application) { }
}
