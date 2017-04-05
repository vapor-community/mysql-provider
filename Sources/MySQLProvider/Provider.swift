import Vapor

public final class Provider: Vapor.Provider {
    public init(config: Config) throws { }

    /// See Vapor.Provider.boot
    public func boot(_ drop: Droplet) throws {
        try drop.addConfigurable(driver: MySQLDriver.Driver.self, name: "mysql")
        // add configurable mysql first since fluent provider
        // might use it for fluent cache
        try drop.addProvider(FluentProvider.Provider.self)
    }

    /// See Vapor.Provider.beforeRun
    public func beforeRun(_ drop: Droplet) {}
}
