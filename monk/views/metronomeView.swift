//
//  metronomeView.swift
//  monk
//
//  Created by flighty on 2024-01-10.
//

import SwiftUI

struct metronomeView: View {
    var body: some View {
        VStack (alignment: .leading) {
            Text("Metronome").font(.title1).foregroundStyle(Color("foreground")).multilineTextAlignment(.leading)
            Spacer()
        }
    }
}

#Preview {
    metronomeView()
}
