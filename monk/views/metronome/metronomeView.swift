//
//  metronomeView.swift
//  monk
//
//  Created by flighty on 2024-01-10.
//

import SwiftUI

struct MetronomeView: View {
    @ObservedObject var viewModel: MetronomeViewModel;
    
    let maxSubdivisionPerRow: Int = 4
    
    var body: some View {
        VStack {
            dial(value: .init(get: {viewModel.tempo}, set: {viewModel.changeTempo(tempo: $0)})).padding(.vertical, 24)
            HStack () {
                Button {viewModel.changeTempo(tempo: viewModel.tempo - 1)} label: { Image(systemName: "arrow.down").tint(Color("brand"))
                }
                Text("\(viewModel.tempo, specifier: "%.0f")")
                    .font(.subTitle1)
                    .foregroundColor(Color("foreground"))
                Button {viewModel.changeTempo(tempo: viewModel.tempo + 1)} label: { Image(systemName: "arrow.up").tint(Color("brand"))
                }
                Spacer()
                Button {viewModel.toggle()} label: { Text(viewModel.isPlaying ? "Stop" : "Play").font(.header).textCase(.lowercase)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .foregroundColor(Color("foreground"))
                    .background(Capsule().foregroundColor(Color("brand")))
                }

            }
            Divider().background(Color("brand"))
            HStack (alignment: .center) {
                VStack {
                    ForEach (0..<3, id: \.self) { rowIndex in
                        HStack {
                            ForEach (0..<maxSubdivisionPerRow, id: \.self) { columnIndex in
                                let index = rowIndex * maxSubdivisionPerRow + columnIndex
                                if (viewModel.subdivisions.indices.contains(index)) {
                                    let isAccent: Bool = viewModel.subdivisions[index] == 1
                                    Button {viewModel.changeSubdivisions(index: index, isAccent: isAccent)} label: { Circle().fill(isAccent ? Color("brand") : Color("secondaryAccent")).stroke(Color("primaryAccent"), style: StrokeStyle(lineWidth: 5)).frame(width: 50, height: 50)
                                    }
                                } else {
                                    Circle().fill(Color("secondaryAccent").opacity(0.0)).stroke(Color("primaryAccent"), style: StrokeStyle(lineWidth: 5)).frame(width: 50, height: 50)
                                }
                                if (columnIndex != maxSubdivisionPerRow - 1) {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.bottom, rowIndex < 2 ? 10 : 0)
                    }
                }
                Divider().background(Color("brand")).padding(.horizontal).frame(height: 200)
                VStack {
                    Button {} label: {
                        VStack {
                            Text("\(viewModel.subdivisions.count)").font(.subTitle1)
                            .foregroundColor(Color("foreground"))
                            .padding(.bottom, 4)
                            Text("Divisions").font(.subTitle3).textCase(.lowercase)
                            .foregroundColor(Color("brand"))
                        }
                    }
                    Divider().background(Color("brand")).padding(.vertical)                    
                    Button {} label: {
                        VStack {
                            Text("\(viewModel.timeSignature, specifier: "%.0f")").font(.subTitle1)
                            .foregroundColor(Color("foreground"))
                            .padding(.bottom, 4)
                            Text("Signature").font(.subTitle3).textCase(.lowercase)
                            .foregroundColor(Color("brand"))
                        }
                    }
                }
            }
            .padding(.vertical)
            Spacer()
        }.padding(.horizontal)
    }
}

#Preview {
    ZStack {
        Color("background")
            .ignoresSafeArea()
        MetronomeView(viewModel: MetronomeViewModel(metronome: Metronome.defaultInstance))
    }
}
