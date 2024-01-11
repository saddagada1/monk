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
    let index: Int
    let namespace: Namespace.ID
    @Binding var selectedIndex: Int

    var body: some View {
        Button { withAnimation(.easeInOut) {
            selectedIndex = index
        }} label: {
            Text(name)
                .font(.header)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .foregroundColor(Color("foreground"))
                .background(isActive ? Capsule().foregroundColor(Color("brand")).matchedGeometryEffect(id: "highlightmenuitem", in: namespace) : nil)
        }
    }
}
