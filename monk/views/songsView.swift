//
//  songsView.swift
//  monk
//
//  Created by flighty on 2024-01-10.
//

import SwiftUI

struct songsView: View {
    var body: some View {
        VStack (alignment: .leading) {
            Text("Songs").font(.title1).foregroundStyle(Color("foreground")).multilineTextAlignment(.leading)
            Spacer()
        }
    }
}

#Preview {
    songsView()
}
