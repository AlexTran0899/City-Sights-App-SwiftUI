//
//  BusinessMap.swift
//  CitySights
//
//  Created by Alex Tran on 3/26/23.

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    @EnvironmentObject var model: ContentModel
    @Binding var selectedBusiness: Business?

    var locations: [MKAnnotation] {
        var annotations = [MKPointAnnotation]()
        // create a set of annotations from our list of businesses
        for business in model.restaurants + model.sights {
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
                a.title = business.name ?? ""
                annotations.append(a)
            }
        }
        return annotations
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        // make the user show up on the map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        // TODO: set the region
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        // add the one based on the business
        uiView.showAnnotations(self.locations, animated: true)
    }
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
    // MARK: Coordinator class
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var map: BusinessMap
        init(map: BusinessMap) {
            self.map = map
        }
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
        
            // check if there's a reusable annotation view first
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.annotationReuseId)
            if annotationView == nil {
                // create an annotation view
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constants.annotationReuseId)
                annotationView!.canShowCallout = true
                annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                // we got a reusable one
                annotationView!.annotation = annotation
            }
            // return it
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            // user tapped on the annotation view
            let title = view.annotation?.title
            // Get the business object that this annotation represent
            // loop through the model and find the correct business using the title
            for business in map.model.restaurants + map.model.sights {
                if business.name == title {
                    // set the selectedBusiness property to that business object
                    map.selectedBusiness = business
                    return
                }
            }
            
            
        }
    }
    
}
//
//struct BusinessMap_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessMap()
//            .environmentObject(ContentModel())
//    }
//}
