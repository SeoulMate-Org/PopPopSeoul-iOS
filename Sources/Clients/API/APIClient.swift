import ComposableArchitecture
import Foundation

/// A Client to dispatch network calls
@DependencyClient
public struct APIClient {
  /// Dispatches a Request and returns its data
  /// - Parameter request: Request to Dispatch
  /// - Returns: The response data of the request
  /// - Throws: A NetworkRquestError if the request fails
  public var send: @Sendable (_ request: Request) async throws -> (Data, URLResponse)
}

extension APIClient: DependencyKey {
  public static var liveValue: APIClient {
    @Dependency(\.networkDispatcher) var networkDispatcher

    return Self { request in
      do {
        guard let urlRequest = try? request.makeRequest() else {
          throw NetworkRequestError.badRequest
        }
        
        // ✅ 요청 로그 출력
        print("============================================================")
        print("📤 [Request]")
        print("🔹 URL: \(urlRequest.url?.absoluteString ?? "")")
        print("🔹 Method: \(urlRequest.httpMethod ?? "")")
        print("🔹 Headers: \(urlRequest.allHTTPHeaderFields ?? [:])")
        if let body = urlRequest.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
          print("🔹 Body: \(bodyString)")
        }
        print("============================================================")
        
        // ✅ 요청 보내기
        let (data, response) = try await networkDispatcher.dispatch(urlRequest)
        
        // ✅ 응답 로그 출력
        print("============================================================")
        print("📥 [Response]")
        if let httpResponse = response as? HTTPURLResponse {
          print("🔸 Status Code: \(httpResponse.statusCode)")
          print("🔸 Headers: \(httpResponse.allHeaderFields)")
        }
        if let responseBody = String(data: data, encoding: .utf8) {
          print("🔸 Body: \(responseBody)")
        }
        print("============================================================")
        
        return (data, response)
      } catch {
        print("❌ APIClient 오류 발생: \(error) \(error.localizedDescription)")
        throw error
      }
    }
  }
}

extension APIClient: TestDependencyKey {
  public static var testValue: APIClient = Self()
  public static let previewValue: APIClient = Self(
    send: { _ in (Data(), HTTPURLResponse()) }
  )
}

public extension DependencyValues {
  var apiClient: APIClient {
    get { self[APIClient.self] }
    set { self[APIClient.self] = newValue }
  }
}
