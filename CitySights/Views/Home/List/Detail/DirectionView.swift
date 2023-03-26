//
//  DirectionView.swift
//  CitySights
//
//  Created by Alex Tran on 3/26/23.
//

import SwiftUI

struct DirectionView: View {
    var business: Business
    var body: some View {
        VStack(alignment: .leading){
            // business title
            HStack {
                BusinessTitle(business: business)
                Spacer()
                if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                    let url = URL(string: "maps://?saddr=&daddr=\(lat),\(long)")
                    Link("Open in maps", destination: url!)
                }
            }.padding()
            // direction map
            DirectionMap(business: business)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct Directionview_Previews: PreviewProvider {
    static var previews: some View {
        DirectionView(business: BusinessMock())
    }
}
