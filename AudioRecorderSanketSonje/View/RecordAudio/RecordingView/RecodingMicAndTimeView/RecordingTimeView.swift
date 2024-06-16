//
//  RecordingTimeView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct RecordingTimeView: View {

    // MARK: - Properties

    @EnvironmentObject var viewModel: AudioRecordingViewModel

    // MARK: - View

    var body: some View {
        Text(viewModel.time)
            .padding(.top, 20)
            .foregroundColor(.white)
            .font(.system(size: 60, weight: .black))
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    RecordingTimeView()
}

#endif
