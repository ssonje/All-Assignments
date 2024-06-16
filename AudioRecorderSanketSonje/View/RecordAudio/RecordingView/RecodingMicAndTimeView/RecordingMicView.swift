//
//  RecordingMicView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct RecordingMicView: View {

    // MARK: - View

    var body: some View {
        Image(systemName: "mic.fill")
            .foregroundColor(.white)
            .font(.system(size: 50))
            .padding(.top, 140)
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    RecordingMicView()
}

#endif
