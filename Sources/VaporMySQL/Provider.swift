import Vapor
import FluentMySQL
import VaporFluent

public final class Provider: Vapor.Provider {
    public init(config: Config) throws { }

    /// See Vapor.Provider.boot
    public func boot(_ drop: Droplet) throws {
        try drop.addProvider(VaporFluent.Provider.self)
        try drop.addConfigurable(driver: MySQLDriver.self, name: "mysql")
    }

    /// See Vapor.Provider.beforeRun
    public func beforeRun(_ drop: Droplet) {}
}
