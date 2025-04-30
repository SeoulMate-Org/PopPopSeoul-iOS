//
//  NaverMap.swift
//  Features
//
//  Created by suni on 4/30/25.
//
import SwiftUI
import NMapsMap
import Models
import SharedAssets

struct NaverMapView: UIViewRepresentable {
  let attractions: [Attraction]
  
  func makeUIView(context: Context) -> NMFNaverMapView {
    let locations = attractions.compactMap { $0.coordinate }
    
    let mapView = NMFNaverMapView(frame: .zero)
    mapView.showZoomControls = false
    mapView.showLocationButton = false
    
    let cameraUpdate = NMFCameraUpdate(
      scrollTo: NMGLatLng(
        lat: locations.first?.latitude ?? Coordinate().latitude,
        lng: locations.first?.longitude ?? Coordinate().longitude)
    )
    cameraUpdate.animation = .easeIn
    mapView.mapView.moveCamera(cameraUpdate)
    
    // 마커 추가
    for attraction in attractions {
      if let location = attraction.coordinate {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: location.latitude, lng: location.longitude)
        marker.mapView = mapView.mapView
        marker.iconImage = NMF_MARKER_IMAGE_BLACK
        marker.iconTintColor = Colors.blue500.color
        marker.width = 25.0
        marker.height = 35.0
        marker.captionText = attraction.name
        marker.captionRequestedWidth = 100
        marker.captionColor = Colors.gray500.color
        marker.mapView = mapView.mapView
      }
    }
    
    return mapView
  }
  
  func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
    // 필요 시 업데이트 처리
  }
}
