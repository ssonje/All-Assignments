//
//  AudioPlaybackView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct AudioPlaybackView: View {

    // MARK: - Properties

    @EnvironmentObject var audioPlaybackViewModel: AudioPlaybackViewModel
    @EnvironmentObject var audioFilesViewModel: AudioFilesViewModel

    private let audio: URL

    // MARK: - Init

    init(audio: URL) {
        self.audio = audio
    }

    // MARK: - View

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    AudioRenameFormSectionView(audio: audio)
                        .environmentObject(audioPlaybackViewModel)
                        .environmentObject(audioFilesViewModel)

                    AudioPlaybackFormSectionView(audio: audio)
                        .environmentObject(audioPlaybackViewModel)
                }
                .padding(.top, 25)
                .padding(.bottom, 25)
            }
        }
        .navigationTitle("Audio Playback")
        .onAppear {
            audioPlaybackViewModel.prepareAudioPlayer(for: audio)
        }
        .onDisappear {
            if audioPlaybackViewModel.isPlaying {
                audioPlaybackViewModel.stop()
            }
        }
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    AudioPlaybackView(audio: URL(string: "TestString.caf")!)
}

#endif
