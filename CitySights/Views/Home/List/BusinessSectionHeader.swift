//
//  BusinessSectionHeader.swift
//  CitySights
//
//  Created by Alex Tran on 3/25/23.
//

import SwiftUI

struct BusinessSectionHeader: View {
    var title: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
            
            Text(title)
                .font(.headline)
        }
    }
}

//struct BusinessSectionHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessSectionHeader(title: "Restaurants")
//    }
//}
