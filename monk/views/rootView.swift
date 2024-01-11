//
//  rootView.swift
//  monk
//
//  Created by flighty on 2024-01-09.
//

import SwiftUI

struct rootView: View {
    enum viewTypes: CaseIterable {
        case looper, tuner, metronome, chords, scales, songs

        var name: String {
            switch self {
            case .looper:
                return "Looper"
            case .tuner:
                return "Tuner"
            case .metronome:
                return "Metronome"
            case .chords:
                return "Chords"
            case .scales:
                return "Scales"
            case .songs:
                return "Songs"
            }
        }
    }

    @ViewBuilder func views(type: viewTypes) -> some View {
        switch type {
        case .looper:
            looperView()
        case .tuner:
            tunerView()
        case .metronome:
            metronomeView()
        case .chords:
            chordsView()
        case .scales:
            scalesView()
        case .songs:
            songsView()
        }
    }

    @State private var selectedIndex = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            Color("background")
                .ignoresSafeArea()
            TabView(selection: $selectedIndex) {
                ForEach(viewTypes.allCases.indices, id: \.self) { index in
                    views(type: viewTypes.allCases[index])
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            tabBar(tabBarLinks: viewTypes.allCases.map { $0.name }, selectedIndex: $selectedIndex)
                .padding()
        }
    }
}

#Preview {
    rootView()
}
