//
//  AudioFilesListView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import AVFoundation
import Foundation
import SwiftUI

struct AudioFilesListView: View {

    // MARK: - Properties

    @EnvironmentObject var audioFilesViewModel: AudioFilesViewModel

    @StateObject var audioPlaybackViewModel = AudioPlaybackViewModel()

    // MARK: - View

    var body: some View {
        if audioFilesViewModel.audios.count == 0 {
            Text("Please record audio...")
                .foregroundColor(.blue)
                .font(.system(size: 50))
        } else {
            NavigationView {
                List {
                    ForEach(audioFilesViewModel.audios, id: \.self) { audio in
                        NavigationLink(destination: AudioPlaybackView(audio: audio).environmentObject(audioPlaybackViewModel).environmentObject(audioFilesViewModel)) {
                            HStack {
                                Image(systemName: "waveform.circle")
                                Text(audio.relativeString)
                            }
                        }.padding()
                    }
                    .navigationTitle("Audio Files")
                }
            }
        }
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    AudioFilesListView()
}

#endif
