//
//  DirectionMAp.swift
//  CitySights
//
//  Created by Alex Tran on 3/26/23.
//

import SwiftUI
import MapKit

struct DirectionMap: UIViewRepresentable{
    @EnvironmentObject var model: ContentModel
    var business: Business
    var start: CLLocationCoordinate2D {
        return model.locationManager.location?.coordinate ?? CLLocationCoordinate2D()
    }
    var end: CLLocationCoordinate2D {
        if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
            return CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        } else {
            return CLLocationCoordinate2D()
        }
    }
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        // show the user location
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
        // Create directions request
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: start))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: end))
        // create directions object
        let direction = MKDirections(request: request)
        // calculate route
        direction.calculate { res, err in
            if err == nil && res != nil {
                for route in res!.routes {
                    map.addOverlay(route.polyline)
                    // zoom into the region
                    map.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100),animated: true)
                }
            }
            // place annotation for the end point
            let annotation = MKPointAnnotation()
            annotation.coordinate = end
            annotation.title = business.name ?? ""
            map.addAnnotation(annotation)
        }
        return map
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
            
    }
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
        uiView.removeOverlays(uiView.overlays)
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            renderer.lineWidth = 5
            renderer.strokeColor = .blue
            return renderer
        }
    }
}
//
//struct DirectionMAp_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionMap()
//    }
//}
