import Foundation

public let logger = DebugLogger()

public final class DebugLogger: Sendable {
  private static let fileLogQueue = DispatchQueue(label: "dev.suni.poppopseoul")
  
  public init() { }
  
  public func debug(
    _ message: String = "",
    filePath: String = #file,
    funcName: String = #function,
    line: Int = #line
  ) {
    printLog(message, symbol: "🍀", filePath: filePath, funcName: funcName, line: line)
  }
  
  public func warn(
    _ message: String = "",
    filePath: String = #file,
    funcName: String = #function,
    line: Int = #line
  ) {
    printLog(message, symbol: "🚧", filePath: filePath, funcName: funcName, line: line)
  }
  
  public func error(
    _ message: String = "",
    filePath: String = #file,
    funcName: String = #function,
    line: Int = #line
  ) {
    printLog(message, symbol: "❌", filePath: filePath, funcName: funcName, line: line)
  }
  
  private func printLog(
    _ message: String,
    symbol: String,
    filePath: String,
    funcName: String,
    line: Int
  ) {
    #if DEBUG || QA
    let fileName = DebugLogger.sourceFileName(filePath: filePath)
    let formatter = DateFormatter.iso8601
    let str = "\(formatter.string(from: Date())) - [\(symbol)|\(fileName).\(funcName)-\(line)] - \(message)"
    print(str)
    
    DebugLogger.fileLogQueue.async {
      SwiftLog.logger.write(str)
    }
    #endif
  }
  
  public static func sourceFileName(filePath: String) -> String {
    let components = filePath.split(separator: "/")
    guard !components.isEmpty else { return "" }
    
    var fileName = components.last
    fileName = fileName?.split(separator: ".").first
    
    return String(fileName ?? "")
  }
}
