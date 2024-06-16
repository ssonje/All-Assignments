//
//  StopRecordingView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct StopRecordingView: View {

    // MARK: - Properties

    @EnvironmentObject var viewModel: AudioRecordingViewModel
    @EnvironmentObject var audioVisualiserViewModel: AudioVisualiserViewModel

    // MARK: - View

    var body: some View {
        ZStack {
            RecordingInProgressOpacityView().environmentObject(viewModel)
            StopRecordingButtonView()
        }
        .offset(y: -200)
        .opacity(viewModel.opacityStop)
        .onTapGesture {
            DispatchQueue.main.async {
                AudioRecorder.sharedInstance.stopRecording()
            }
            viewModel.animateCircleAfterStopRecoding()
            audioVisualiserViewModel.isVisualiserRunning = false
        }
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    StopRecordingView()
}

#endif
