extension ZeneaHTTPClient {
    public enum Scheme: String {
        case http
        case https
    }
}

extension ZeneaHTTPClient.Scheme: CustomStringConvertible {
    public var description: String { self.rawValue }
}

extension ZeneaHTTPClient.Scheme: Codable { }
extension ZeneaHTTPClient.Scheme: Hashable { }
