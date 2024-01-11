//
//  metronomeView.swift
//  monk
//
//  Created by flighty on 2024-01-10.
//

import SwiftUI

struct metronomeView: View {
    @State private var bpm: CGFloat = 100
    var body: some View {
        VStack {
            dial(value: $bpm).padding(.vertical, 24)
            HStack {
                Text("\(self.bpm, specifier: "%.0f")")
                    .font(.subTitle1)
                    .foregroundColor(Color("foreground"))
                Spacer()
                Button {} label: { Text("Play").font(.header)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .foregroundColor(Color("foreground"))
                    .background(Capsule().foregroundColor(Color("brand")))
                }

            }.padding(.horizontal)
            Divider().padding(.horizontal).background(Color("brand"))
            Spacer()
        }
    }
}

#Preview {
    ZStack {
        Color("background")
            .ignoresSafeArea()
        metronomeView()
    }
}
