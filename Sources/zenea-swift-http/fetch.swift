import Zenea

extension ZeneaHTTPClient {
    public func fetchBlock(id: Block.ID) async -> Result<Block, Block.FetchError> {
        let response = client.get(url: server.construct() + "/block/" + id.description)
        
        do {
            let result = try await response.get()
            
            switch result.status {
            case .ok: break
            case .notFound: return .failure(.notFound)
            default: return .failure(.unable)
            }
            
            guard let body = result.body else { return .failure(.invalidContent) }
            guard let data = body.getData(at: 0, length: body.readableBytes) else { return .failure(.invalidContent) }
            
            let block = Block(content: data)
            guard block.matchesID(id) else { return .failure(.invalidContent) }
            
            return .success(block)
        } catch {
            return .failure(.unable)
        }
    }
}
