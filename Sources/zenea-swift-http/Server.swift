extension ZeneaHTTPClient {
    public struct Server {
        public var scheme: Scheme
        public var address: String
        public var port: Int
        
        public init(scheme: Scheme, address: String, port: Int) {
            self.scheme = scheme
            self.address = address
            self.port = port
        }
    }
}

extension ZeneaHTTPClient.Server: Codable { }
extension ZeneaHTTPClient.Server: Hashable { }

extension ZeneaHTTPClient.Server: CustomStringConvertible {
    public var description: String { self.construct() }
}

extension ZeneaHTTPClient.Server {
    public func construct() -> String {
        "\(self.scheme)://\(self.address):\(self.port)"
    }
    
    fileprivate static let _serverPattern = try! Regex("(?<scheme>https?)://(?<address>([A-Za-z0-9]+\\.)*[A-Za-z0-9]+|\\[[a-f0-9:]+\\]):(?<port>[0-9]+)")
    
    public init?(parsing string: String) {
        guard let match = string.wholeMatch(of: Self._serverPattern) else { return nil }
        
        guard let schemeSubstring = match["scheme"]?.substring else { return nil }
        guard let scheme = ZeneaHTTPClient.Scheme(rawValue: String(schemeSubstring)) else { return nil }
        self.scheme = scheme
        
        guard let addressSubstring = match["address"]?.substring else { return nil }
        self.address = String(addressSubstring)
        
        guard let portSubstring = match["port"]?.substring else { return nil }
        guard let port = Int(String(portSubstring)) else { return nil }
        self.port = port
    }
}
