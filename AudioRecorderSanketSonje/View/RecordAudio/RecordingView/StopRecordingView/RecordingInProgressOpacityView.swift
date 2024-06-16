//
//  RecordingInProgressOpacityView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct RecordingInProgressOpacityView: View {

    // MARK: - Properties

    @EnvironmentObject var viewModel: AudioRecordingViewModel

    // MARK: - View

    var body: some View {
        Circle()
            .fill(.white)
            .frame(width: 100, height: 100)
            .opacity(viewModel.opacityWave)
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    RecordingInProgressOpacityView()
}

#endif
