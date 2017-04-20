import Vapor

extension Droplet {
    /// Returns the current MySQL driver or throws
    /// an error.
    /// This is a convenience for casting the 
    /// drop.database.driver as a MySQLDriver type.
    public func mysql() throws -> MySQLDriver.Driver {
        let database = try assertDatabase()
        
        guard let driver = database.driver as? MySQLDriver.Driver else {
            throw MySQLProviderError.invalidFluentDriver(database.driver)
        }
        
        return driver
    }
}
