//
//  BusinessSection.swift
//  CitySights
//
//  Created by Alex Tran on 3/25/23.
//

import SwiftUI

struct BusinessSection: View {
    var title: String
    var businesses: [Business]
    var body: some View {
        Section(header: BusinessSectionHeader(title: title)) {
            ForEach(businesses) { business in
                NavigationLink {
                    BusinessDetail(business: business)
                } label: {
                    BusinessRow(business: business)
                    Divider()
                }
            }
        } .padding([.horizontal])
    }
}
