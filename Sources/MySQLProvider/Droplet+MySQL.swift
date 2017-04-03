import Vapor

extension Droplet {
    /// Returns the current MySQL driver or throws
    /// an error.
    /// This is a convenience for casting the 
    /// drop.database.driver as a MySQLDriver type.
    public func mysql() throws -> MySQLDriver {
        guard let database = self.database else {
            throw MySQLProviderError.noDatabase
        }
        
        guard let driver = database.driver as? MySQLDriver else {
            throw MySQLProviderError.invalidFluentDriver(database.driver)
        }
        
        return driver
    }
}
