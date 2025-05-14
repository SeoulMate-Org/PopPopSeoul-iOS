import ComposableCoreLocation
import Foundation

/// A structure for that parses lat and long to represent a coordinate.
public struct Coordinate: Codable, Hashable {
  public init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }

  public let latitude: Double  // 위도
  public let longitude: Double  // 경도
}

public extension Coordinate {
  init(_ location: Location) {
    latitude = location.coordinate.latitude
    longitude = location.coordinate.longitude
  }
  
  init(_ coordinate: CLLocationCoordinate2D) {
    self.latitude = coordinate.latitude
    self.longitude = coordinate.longitude
  }
  
  init() {
    self.latitude = 37.5701816
    self.longitude = 126.9831213
  }
}

public extension Coordinate {
  var asCLLocationCoordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }

  func distance(from coordinate: Coordinate) -> Double {
    CLLocation(self).distance(from: CLLocation(coordinate))
  }
  
  func distanceFormatted(from coordinate: Coordinate) -> String {
    let distance = self.distance(from: coordinate)
    if distance < 1000 {
      return "\(Int(distance))m"
    } else {
      let km = distance / 1000
      return String(format: "%.1fkm", km)
    }
  }
}

public extension CLLocation {
  convenience init(_ coordinate: Coordinate) {
    self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
  }
}
