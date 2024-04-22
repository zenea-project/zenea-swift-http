import Vapor
import Zenea

public class ZeneaHTTPClient: BlockStorage {
    public var server: Server
    public var client: HTTPClient
    
    public init(_ target: Server, client: HTTPClient) {
        self.server = target
        self.client = client
    }
    
    public init(scheme: Scheme = .https, address: String, port: Int = 4096, client: HTTPClient) {
        self.server = .init(scheme: scheme, address: address, port: port)
        self.client = client
    }
}
