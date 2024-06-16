//
//  StopRecordingButtonView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct StopRecordingButtonView: View {

    // MARK: - View

    var body: some View {
        Image(systemName: "stop.fill")
            .foregroundColor(.white)
            .font(.system(size: 24))
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    StopRecordingButtonView()
}

#endif
