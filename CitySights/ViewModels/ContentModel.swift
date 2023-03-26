//
//  ContentModel.swift
//  CitySights
//
//  Created by Alex Tran on 3/25/23.


import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
    override init() {
        // init method of NSObject
        super.init()
        // set content model as the delegate of the location manager
        locationManager.delegate = self
        // request permision from the user
        locationManager.requestWhenInUseAuthorization()
        // start geolocating the user, after we get permision
        // locationManager.startUpdatingLocation()
    }
    // MARK: - Location manager delegate methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied, .notDetermined:
            print("we need permision")
        default:
            print("not valid")
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // give us the location of the user
        let userlocation = locations.first
        if userlocation != nil {
            // stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            // pass tse cordinate in yelp api
            getBusinesses(category: "arts", location: userlocation!)
        }
    }
    
    // MARK: - yelp api methods
    func getBusinesses(category: String, location: CLLocation) {
        // create url
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: String(6)),
        ]
        
        let url = urlComponents?.url
        
        if let url = url {
            // create urlrequest
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiToken)", forHTTPHeaderField: "Authorization")
            // get urlsession
            let session = URLSession.shared
            
            // create datatask
            let dataTask = session.dataTask(with: request) { data, res , err in
                if err == nil {
                    let decoder = JSONDecoder()

                }
            }
            // start the datatask
            dataTask.resume()
        }
    }
}


