import Vapor
import FluentMySQL
import VaporFluent

public final class Provider: Vapor.Provider {
    public init(config: Config) throws { }

    /// See Vapor.Provider.boot
    public func boot(_ drop: Droplet) {
        drop.addConfigurable(driver: MySQLDriver.self, name: "mysql")
    }

    /// See Vapor.Provider.afterInit
    public func afterInit(_ drop: Droplet) {}

    /// See Vapor.Provider.beforeRun
    public func beforeRun(_ drop: Droplet) {}
}
