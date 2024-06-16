//
//  PauseRecordingView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct PauseRecordingView: View {

    // MARK: - Properties

    @EnvironmentObject var viewModel: AudioRecordingViewModel
    @EnvironmentObject var audioVisualiserViewModel: AudioVisualiserViewModel

    // MARK: - View

    var body: some View {
        ZStack {
            if viewModel.isPaused {
                Image(systemName: "play.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 100))
                    .opacity(0.9)
                    .onTapGesture {
                        DispatchQueue.main.async {
                            do {
                                try AudioRecorder.sharedInstance.resumeRecording()
                            } catch {
                                AudioRecorderLogger.sharedInstance.debug("[StartRecordingView] Failed to resume the recording with error: \(error.localizedDescription)")
                            }
                        }
                        audioVisualiserViewModel.isVisualiserRunning = true
                        viewModel.updatePropertiesAfterResumeAction()
                    }
            } else {
                Image(systemName: "pause.circle.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 100))
                    .opacity(0.9)
                    .onTapGesture {
                        DispatchQueue.main.async {
                            AudioRecorder.sharedInstance.pauseRecording()
                        }
                        audioVisualiserViewModel.isVisualiserRunning = false
                        viewModel.updatePropertiesAfterPauseAction()
                    }
            }
        }
        .offset(y: -200)
        .opacity(1.0)
        .padding()
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    PauseRecordingView()
}

#endif
