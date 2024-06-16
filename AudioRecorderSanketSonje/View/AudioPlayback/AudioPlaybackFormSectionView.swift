//
//  AudioPlaybackFormSectionView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 02/06/24.
//

import SwiftUI

struct AudioPlaybackFormSectionView: View {

    // MARK: - Properties

    @EnvironmentObject var audioPlaybackViewModel: AudioPlaybackViewModel

    private let audio: URL

    // MARK: - Init

    init(audio: URL) {
        self.audio = audio
    }

    // MARK: - View

    var body: some View {
        Section(header: Text("Play / Stop Audio")) {
            VStack {
                if !audioPlaybackViewModel.isPlaying {
                    HStack {
                        Image(systemName: "play.circle")
                            .foregroundColor(.blue)
                            .font(.system(size: 25))
                        Text("Play Audio")
                            .foregroundColor(.blue)
                            .font(.system(size: 25))
                    }
                    .onTapGesture {
                        audioPlaybackViewModel.play()
                    }
                }

                if audioPlaybackViewModel.isPlaying {
                    HStack {
                        Image(systemName: "stop.circle")
                            .foregroundColor(.blue)
                            .font(.system(size: 25))
                        Text("Stop Audio")
                            .foregroundColor(.blue)
                            .font(.system(size: 25))
                    }
                    .onTapGesture {
                        audioPlaybackViewModel.stop()
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    AudioPlaybackFormSectionView(audio: URL(string: "TestString.caf")!)
}

#endif
