//
//  RecordingView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct RecordingView: View {

    // MARK: - Properties

    @EnvironmentObject var viewModel: AudioRecordingViewModel
    @EnvironmentObject var audioVisualiserViewModel: AudioVisualiserViewModel

    // MARK: - View

    var body: some View {
        VStack {
            RecordingMicView()

            RecordingTimeView()
                .environmentObject(viewModel)

            AudioVisualiserView()
                .environmentObject(audioVisualiserViewModel)

            Spacer()

            HStack {
                PauseRecordingView()
                    .environmentObject(viewModel)
                    .environmentObject(audioVisualiserViewModel)

                StopRecordingView()
                    .environmentObject(viewModel)
                    .environmentObject(audioVisualiserViewModel)
            }
        }
        .frame(height: (UIScreen.main.bounds.height))
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    RecordingView()
}

#endif
