import Zenea

extension ZeneaHTTPClient {
    public func listBlocks() async -> Result<Set<Block.ID>, Block.ListError> {
        let response = client.get(url: server.construct() + "/blocks")
        
        do {
            let result = try await response.get()
            
            switch result.status {
            case .ok: break
            case .internalServerError: return .failure(.unable)
            default: return .failure(.unable)
            }
            
            guard let body = result.body else { return .failure(.unable) }
            guard let data = body.getData(at: 0, length: body.readableBytes) else { return .failure(.unable) }
            guard let string = String(data: data, encoding: .utf8) else { return .failure(.unable) }
            
            var results: Set<Block.ID> = []
            
            let values = string.split(separator: ",")
            for value in values {
                guard let id = Block.ID(parsing: String(value)) else { continue }
                results.insert(id)
            }
            
            return .success(results)
        } catch {
            return .failure(.unable)
        }
    }
}
