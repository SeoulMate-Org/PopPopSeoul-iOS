import ComposableArchitecture
import Foundation
import Common

@DependencyClient
public struct NaverMapsClient {
  public var send: @Sendable (_ endpoint: NaverMapsEndpoint) async throws -> Data
}

extension NaverMapsClient: DependencyKey {
  public static let liveValue: NaverMapsClient = .init { endpoint in
    let request = endpoint.urlRequest
    
    let message: String = """
                  
      ================ HTTP REQUEST ================
      url: \(request.url?.absoluteString ?? "nil")
      method: \(request.httpMethod ?? "nil")
      headers: \(String(describing: request.allHTTPHeaderFields))
      body: \(request.httpBody.flatMap { String(data: $0, encoding: .utf8) } ?? "nil")
      ==============================================
      
      """
    logger.debug(message)
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    if let httpResponse = response as? HTTPURLResponse {
      let responseBody = String(data: data, encoding: .utf8) ?? "binary (\(data.count) bytes)"
      var message: String = """
                    
        ================ HTTP RESPONSE ================
        url: \(request.url?.absoluteString ?? "nil")
        status: \(httpResponse.statusCode)
        Body: \(responseBody)
        
        """
      logger.debug(message)
    }
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200..<300).contains(httpResponse.statusCode) else {
      logger.error("❌ API 응답 실패: 상태 코드 \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
      throw URLError(.badServerResponse)
    }
    
    return data
  }
}

extension DependencyValues {
  public var naverMapsClient: NaverMapsClient {
    get { self[NaverMapsClient.self] }
    set { self[NaverMapsClient.self] = newValue }
  }
}
