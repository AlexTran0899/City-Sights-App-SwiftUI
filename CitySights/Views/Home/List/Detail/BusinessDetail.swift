//
//  BusinessDetail.swift
//  CitySights
//
//  Created by Alex Tran on 3/26/23.
//

import SwiftUI

struct BusinessDetail: View {
    var business: Business
    var body: some View {
        
        VStack(alignment: .leading) {
            // business image
            VStack(spacing: 0){
                GeometryReader { geo in
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }
                ZStack(alignment: .leading){
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    Text(business.isClosed! ? "Closed": "Open")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                }
            }.edgesIgnoringSafeArea(.top)
            VStack( alignment: .leading ,spacing: 20) {
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
                Divider()
                // phone
                HStack{
                    Text("Phone: ").bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    if business.phone != nil {
                        Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                    }
                }
                Divider()
                // reviews
                HStack{
                    Text("Reviews:")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: business.url ?? "")!)
                }
                Divider()
                HStack{
                    Text("Website:")
                        .bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: business.url ?? "")!)
                }
                Spacer()
                Button {
                    print("here")
                } label: {
                    ZStack{
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                        Text("Get Direction")
                            .foregroundColor(.white)
                            .bold()
                    }.padding(.bottom)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct BusinessDetail_Previews: PreviewProvider {
    static var previews: some View {
        BusinessDetail(business: BusinessMock())
    }
}
