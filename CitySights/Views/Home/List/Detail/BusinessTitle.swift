//
//  BusinessName.swift
//  CitySights
//
//  Created by Alex Tran on 3/26/23.
//

import SwiftUI

struct BusinessTitle: View {
    var business: Business
    var body: some View {
        VStack(alignment: .leading) {
            // business name
            Text(business.name ?? "")
                .font(.largeTitle)
            // address
            if business.location?.display_address != nil {
                VStack(alignment: .leading){
                    ForEach(business.location!.display_address!, id: \.self) { displayLine in
                        Text(displayLine)
                    }
                    Image("regular_\(business.rating ?? 0)")
                }
            }
            
        }
    }
}

struct BusinessName_Previews: PreviewProvider {
    static var previews: some View {
        BusinessTitle(business: BusinessMock())
    }
}
