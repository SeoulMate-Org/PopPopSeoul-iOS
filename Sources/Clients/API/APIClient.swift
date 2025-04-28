import ComposableArchitecture
import Foundation
import Common

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
    @Dependency(\.authClient) var authClient
    
    return Self { request in
      do {
        guard let urlRequest = try? request.makeRequest() else {
          throw NetworkRequestError.invalidRequest
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")// UTC 시간대 설정
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let utcTimeString = dateFormatter.string(from: Date())
        
        let headers = urlRequest.allHTTPHeaderFields ?? [:]
        let method = urlRequest.httpMethod ?? "nil"
        let urlStr = urlRequest.url?.absoluteString ?? "nil"
        if let body = urlRequest.httpBody {
          let bodyString = String(bytes: body, encoding: .utf8) ?? "nil"
          let message: String = """
                        
            ================ HTTP REQUEST ================
            url: \(urlStr) - \(utcTimeString)
            method: \(method)
            url: \(urlStr)
            headers: \(headers)
            body: \(bodyString)
            ==============================================
            
            """
          logger.debug(message)
        } else {
          let message: String = """
                        
            ================ HTTP REQUEST ================
            url: \(urlStr) - \(utcTimeString)
            method: \(method)
            headers: \(headers)
            body: nil
            ==============================================
            
            """
          logger.debug(message)
        }
        
        let (data, response) = try await networkDispatcher.dispatch(urlRequest)
        
        // MARK: - 여기서 오류 발생
        var message: String = """
                        
            ================ HTTP RESPONSE ================
            url: \(urlStr) - \(utcTimeString)
            method: \(method)\n
            """
        
        if let httpResponse = response as? HTTPURLResponse {
          message += "status Code: \(httpResponse.statusCode)\n"
        }
        
        message += "response: \(data.toPrettyPrintedString ?? "nil")\n"
        message += "==============================================\n"
        logger.debug(message)
        
        return (data, response)
      } catch {
        if let apiError = error as? APIErrorResponse, apiError.errorCode == .expiredAccessToken {
          if await authClient.isRefreshing() {
            logger.error("⚠️ 이미 refresh 중입니다. 재시도하지 않습니다.")
            throw error
          }
          do {
            try await authClient.refresh() // ✅ 여기서 refresh 호출
            logger.debug("✅ 토큰 갱신 성공. 원래 요청 재시도")
            // ✅ 토큰 갱신에 성공했으면 원래 요청 다시 시도
            guard let retryRequest = try? request.makeRequest() else {
              throw NetworkRequestError.invalidRequest
            }
            return try await networkDispatcher.dispatch(retryRequest)
            
          } catch {
            logger.error("❌ 토큰 갱신 실패. 로그아웃 진행 - error: \(error.localizedDescription)")
            throw error // 최종 실패
          }
        } else {
          throw error
        }
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

extension Data {
  var toPrettyPrintedString: String? {
    guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
          let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
          let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
    return prettyPrintedString as String
  }
}
