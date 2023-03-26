//
//  CitySightsApp.swift
//  CitySights
//
//  Created by Alex Tran on 3/25/23.
//

import SwiftUI

@main
struct CitySightsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
