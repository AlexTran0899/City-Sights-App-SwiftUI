//
//  HomeView.swift
//  CitySights
//
//  Created by Alex Tran on 3/25/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    @State var isMapShowing = false
    @State var selectedBusiness: Business?
    
    var body: some View {
        if model.restaurants.count != 0 || model.sights.count != 0 {
            // determine if we should show the list view or map view
            NavigationView {
                if !isMapShowing {
                    // ShowList
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "location")
                            Text("San Francisco")
                            Spacer()
                            Button {
                                self.isMapShowing = true
                            } label: {
                                Text("Switch to map view")
                            }
                        }.padding(.horizontal)
                        Divider()
                        BusinessList()
                    }.navigationBarHidden(true)
                } else {
                    // show map view
                    BusinessMap(selectedBusiness: $selectedBusiness)
                        .ignoresSafeArea()
                        .sheet(item: $selectedBusiness) { business in
                            // create a business detail view instance
                            // pass in the selected business
                            BusinessDetail(business: business)
                        }
                }
            }
        } else {
            ProgressView()
        }
    }
}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//            .environmentObject(ContentModel())
//    }
//}
