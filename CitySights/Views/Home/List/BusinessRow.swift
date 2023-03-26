//
//  BusinessRow.swift
//  CitySights
//
//  Created by Alex Tran on 3/26/23.
//

import SwiftUI

struct BusinessRow: View {
    @ObservedObject var business: Business
    
    var body: some View {
        VStack(alignment:.leading){
            HStack{
                // image
                let uiImage = UIImage(data: business.imageData ?? Data())
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .frame(width: 58, height: 58)
                    .cornerRadius(5)
                    .scaledToFit()
                VStack(alignment:.leading) {
                    Text(business.name ?? "")
                        .multilineTextAlignment(.leading)
                        .bold()
                    Text(String(format: "%.1f", (business.distance ?? 0) / 1000) + " km away")
                }
                Spacer()
                // star rating and number of reviews
                VStack(alignment:.leading) {
                    Image("regular_\(business.rating ?? 0)")
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
            }
            .accentColor(.black )
            Divider()
        }
    }
}
//
//struct BusinessRow_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessRow()
//    }
//}
