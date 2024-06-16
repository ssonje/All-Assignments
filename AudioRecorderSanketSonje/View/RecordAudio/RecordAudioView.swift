//
//  RecordAudioView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct RecordAudioView: View {

    // MARK: - Properties

    @StateObject var viewModel = AudioRecordingViewModel()
    @StateObject var audioVisualiserViewModel = AudioVisualiserViewModel()

    // MARK: - View

    var body: some View {
        ZStack {
            StartRecordingView()
                .environmentObject(viewModel)
                .environmentObject(audioVisualiserViewModel)

            ZStack {
                AnimatingCircleView()
                    .environmentObject(viewModel)

                if viewModel.circleSize > 0.0 {
                    RecordingView()
                        .environmentObject(viewModel)
                        .environmentObject(audioVisualiserViewModel)
                }
            }
        }
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    RecordAudioView()
}

#endif
