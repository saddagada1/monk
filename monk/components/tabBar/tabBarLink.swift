//
//  tabBarLink.swift
//  monk
//
//  Created by flighty on 2024-01-10.
//

import SwiftUI

struct tabBarLink: View {
    var name: String
    var isActive: Bool = false
    let namespace: Namespace.ID
     
    var body: some View {
        Text(name)
            .font(.header)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .foregroundColor(Color("foreground"))
            .background(isActive ? Capsule().foregroundColor(Color("brand")).matchedGeometryEffect(id: "highlightmenuitem", in: namespace) : nil)
     
    }
}
