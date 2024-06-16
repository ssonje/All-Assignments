//
//  AudioRenameFormSectionView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 02/06/24.
//

import SwiftUI

struct AudioRenameFormSectionView: View {

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
        Section(header: Text("Rename File")) {
            if !audioPlaybackViewModel.errorMessage.isEmpty {
                Text(audioPlaybackViewModel.errorMessage)
                    .foregroundStyle(.red)
            }

            TextField("Enter New File Name", text: $audioPlaybackViewModel.newFileName)
            HStack {
                Text("Reset File Name")
                    .foregroundStyle(.blue)
                    .bold()
                    .onTapGesture {
                        audioPlaybackViewModel.newFileName = ""
                    }
                Spacer()
                Text("Update File Name")
                    .foregroundStyle(.blue)
                    .bold()
                    .onTapGesture {
                        audioPlaybackViewModel.updateFileName(
                            for: audio,
                            with: audioPlaybackViewModel.newFileName)
                        audioFilesViewModel.updateAudios()
                        audioPlaybackViewModel.newFileName = ""
                    }
            }
        }
        .onAppear {
            audioPlaybackViewModel.errorMessage = ""
        }
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    AudioRenameFormSectionView(audio: URL(string: "TestString.caf")!)
}

#endif
