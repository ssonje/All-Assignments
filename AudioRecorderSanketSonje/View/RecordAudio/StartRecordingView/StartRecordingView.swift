//
//  StartRecordingView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct StartRecordingView: View {

    // MARK: - Properties

    @EnvironmentObject var viewModel: AudioRecordingViewModel
    @EnvironmentObject var audioVisualiserViewModel: AudioVisualiserViewModel

    // MARK: - View

    var body: some View {
        VStack {
            Text("Record Audios")
                .foregroundColor(.blue)
                .font(Font.largeTitle.bold())
                .padding(.bottom, 100)
            ZStack {
                Circle()
                    .fill(.blue)
                    .frame(width: 70, height: 70)

                Image(systemName: "mic.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
            }
            .opacity(viewModel.opacityRecord)
            .onTapGesture {
                DispatchQueue.main.async {
                    do {
                        try AudioRecorder.sharedInstance.startRecording(on: Date())
                    } catch {
                        AudioRecorderLogger.sharedInstance.debug("[StartRecordingView] Failed to start the recording with error: \(error.localizedDescription)")
                    }
                }
                viewModel.animateCircleAfterStartRecoding()
                audioVisualiserViewModel.isVisualiserRunning = true
            }
        }
        .frame(height: (UIScreen.main.bounds.height))
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    StartRecordingView()
}

#endif
