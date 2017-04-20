import Vapor

public final class Provider: Vapor.Provider {
    public static let repositoryName = "mysql-provider"
    
    public init(config: Config) throws { }
    
    
    public func boot(_ config: Config) throws {
        // add the fluent provider so the end user doesn't have to
        try config.addProvider(FluentProvider.Provider.self)
        // add the mysql driver
        config.addConfigurable(driver: MySQLDriver.Driver.init, name: "mysql")
    }

    public func boot(_ drop: Droplet) throws { }
    public func beforeRun(_ drop: Droplet) {}
}
