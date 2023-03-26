//
//  BusinessMap.swift
//  CitySights
//
//  Created by Alex Tran on 3/26/23.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    @EnvironmentObject var model: ContentModel
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
}


struct BusinessMap_Previews: PreviewProvider {
    static var previews: some View {
        BusinessMap()
    }
}
