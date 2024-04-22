import Foundation
import Zenea

extension ZeneaHTTPClient {
    public func putBlock<Bytes>(content: Bytes) async -> Result<Block, Block.PutError> where Bytes: AsyncSequence, Bytes.Element == Data {
        guard let content = try? await content.read() else { return .failure(.unable) }
        guard content.count <= Block.maxBytes else { return .failure(.overflow) }
        
        let block = Block(content: content)
        let response = client.post(url: server.construct() + "/block", body: .data(block.content))
        
        do {
            let result = try await response.get()
            
            switch result.status {
            case .ok: break
            case .notFound: return .failure(.exists(block))
            case .badGateway: return .failure(.unavailable)
            case .forbidden: return .failure(.notPermitted)
            default: return .failure(.unable)
            }
            
            guard let body = result.body else { return .failure(.unable) }
            guard let data = body.getData(at: 0, length: body.readableBytes) else { return .failure(.unable) }
            
            guard let dataString = String(data: data, encoding: .utf8) else { return .failure(.unable) }
            guard let id = Block.ID(parsing: dataString) else { return .failure(.unable) }
            guard block.matchesID(id) else { return .failure(.unable) }
            
            return .success(block)
        } catch {
            return .failure(.unavailable)
        }
    }
}
