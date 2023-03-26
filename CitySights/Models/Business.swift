//
//  Business.swift
//  CitySights
//
//  Created by Alex Tran on 3/25/23.
//

import Foundation

class Business: Decodable, Identifiable, ObservableObject {
    @Published var imageData: Data?
    var id: String?
    var alias: String?
    var name: String?
    var imageUrl: String?
    var isClosed: Bool?
    var url: String?
    var reviewCount: Int?
    var categories: [Category]?
    var rating: Double?
    var coordinates: Coordinate?
    var transactions: [String]?
    var price: String?
    var location: Location?
    var phone: String?
    var displayPhone: String?
    var distance: Double?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case displayPhone = "display_phone"
        
        case id
        case alias
        case name
        case url
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case location
        case phone
        case distance
    }
    func getImageData() {
        // Check that image url isn't nil
        guard imageUrl != nil else {
            return
        }
        // download the data for the image
        if let url = URL(string: imageUrl!) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data, res , err in
                if err == nil {
                    DispatchQueue.main.async {
                        // set the image data
                        self.imageData = data!
                    }
                }
            }
            // fire off the request
            dataTask.resume()
        }
    }
}

struct Category: Decodable {
    var alias: String?
    var title: String?
}

struct Coordinate: Decodable {
    var latitude: Float?
    var longitude: Float?
}
struct Location: Decodable {
    var address1: String?
    var address2: String?
    var address3: String?
    var city: String?
    var zip_code: String?
    var country: String?
    var state: String?
    var display_address: [String]?
}

class BusinessMock: Business {
    override init() {
        super.init()
        self.id = "1"
        self.alias = "mock-business"
        self.name = "Mock Business"
        self.imageUrl = "https://s3-media0.fl.yelpcdn.com/bphoto/isJo6TU49zu-l-eguxJSiw/o.jpg"
        self.isClosed = false
        self.url = "https://example.com/mock-business"
        self.reviewCount = 10
        self.categories = [Category(alias: "restaurants", title: "Restaurants")]
        self.rating = 4.5
        self.coordinates = Coordinate(latitude: 37.7749, longitude: -122.4194)
        self.transactions = ["delivery", "pickup"]
        self.price = "$$"
        self.location = Location(
            address1: "123 Main St",
            city: "San Francisco",
            zip_code: "94111",
            country: "US",
            state: "CA",
            display_address: ["123 Main St", "San Francisco, CA 94111"]
        )
        self.phone = "123-456-7890"
        self.displayPhone = "+1-123-456-7890"
        self.distance = 1.5
        self.getImageData()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
