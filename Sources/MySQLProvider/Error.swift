public enum MySQLProviderError: Error {
    case noDatabase
    case invalidFluentDriver(Driver)
    case unspecified(Error)
}

extension MySQLProviderError: Debuggable {
    public var reason: String {
        switch self {
        case .noDatabase:
            return "No database has been configured."
        case .invalidFluentDriver(let driver):
            return "Invalid Fluent driver: \(type(of: driver)). MySQL driver required."
        case .unspecified(let error):
            return "Unknown: \(error)"
        }
    }
    
    public var identifier: String {
        switch self {
        case .noDatabase:
            return "noDatabase"
        case .invalidFluentDriver:
            return "invalidFluentDriver"
        case .unspecified:
            return "unknown"
        }
    }
    
    public var possibleCauses: [String] {
        switch self {
        case .noDatabase:
            return [
                "You have not added the `MySQLProvider.Provider` to your Droplet."
            ]
        case .invalidFluentDriver:
            return [
                "You have not added the `MySQLProvider.Provider` to your Droplet.",
                "You have not specified `mysql` in the `fluent.json` file.",
                "`drop.database` is getting set programatically to a non-MySQL database"
            ]
        case .unspecified:
            return []
        }
    }
    
    public var suggestedFixes: [String] {
        return [
            "Ensure you have properly configured the MySQLProvider package according to the documentation"
        ]
    }
    
    public var documentationLinks: [String] {
        return [
            "https://docs.vapor.codes/2.0/mysql/package/"
        ]
    }
}
