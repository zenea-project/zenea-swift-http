import Zenea

extension ZeneaHTTPClient {
    public func checkBlock(id: Block.ID) async -> Result<Bool, Block.CheckError> {
        let response = client.execute(.HEAD, url: server.construct() + "/block/" + id.description)
        
        do {
            let result = try await response.get()
            
            switch result.status {
            case .ok: return .success(true)
            case .notFound: return .success(false)
            default: return .failure(.unable)
            }
        } catch {
            return .failure(.unable)
        }
    }
}
