//
//  OnboardingView.swift
//  CitySights
//
//  Created by Alex Tran on 3/26/23.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var model: ContentModel
    private let blue = Color(red: 0.007, green: 0.446, blue: 0.628)
    private let green = Color(red: 0.218, green: 0.771, blue: 0.749)
    @State private var tabSelection = 0
    var body: some View {
        ZStack {
            VStack {
                // tab view
                TabView(selection: $tabSelection) {
                    // first tab
                    VStack{
                        Image("city1")
                            .resizable()
                            .scaledToFit()
                        Text("Welcome to city Sights!")
                            .font(.title)
                            .bold()
                            .padding()
                        Text("City Sights helps you find the best of the city!")
                            .multilineTextAlignment(.center)
                    }.tag(0)
                        .foregroundColor(.white)
                    // second tab
                    VStack {
                        Image("city2")
                            .resizable()
                            .scaledToFit()
                        Text("Ready to discover your city")
                            .font(.title)
                            .bold()
                            .padding()
                        Text("We'll show you the best restaurants, venues and more, based on your location!")
                            .multilineTextAlignment(.center)
                            
                    }.tag(1)
                        .foregroundColor(.white)
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    
                // buttons
                Button {
                    if tabSelection == 0 {
                        tabSelection = 1
                    } else {
                        // get user location
                        model.requestGeoLocationPermission()
                    }
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(height: 48)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                        Text(tabSelection == 0 ? "Next" : "Get my location")
                            .bold()
                            .foregroundColor(.black)
                    }.padding(20)
                }
            }
        }.background(tabSelection == 0 ? green : blue)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
