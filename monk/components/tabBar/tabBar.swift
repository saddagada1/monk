//
//  tabBar.swift
//  monk
//
//  Created by flighty on 2024-01-09.
//

import SwiftUI

struct tabBar: View {
    var tabBarLinks: [String]

    @Binding var selectedIndex: Int
    @Namespace private var menuItemTransition

    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tabBarLinks.indices, id: \.self) { index in
                        tabBarLink(name: tabBarLinks[index], isActive: selectedIndex == index, index: index, namespace: menuItemTransition, selectedIndex: $selectedIndex)
                    }
                }
            }
            .padding(12)
            .background(Color("primaryAccent"))
            .cornerRadius(50)
            .onChange(of: selectedIndex) { _, index in
                withAnimation {
                    scrollView.scrollTo(index, anchor: .center)
                }
            }
        }
    }
}
