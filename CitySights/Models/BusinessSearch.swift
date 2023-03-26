//
//  BusinessSearch.swift
//  CitySights
//
//  Created by Alex Tran on 3/25/23.
//

import Foundation
struct BusinessSearch: Decodable {
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}
