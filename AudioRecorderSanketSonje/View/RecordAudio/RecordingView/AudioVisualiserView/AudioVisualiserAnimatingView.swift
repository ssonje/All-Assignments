//
//  AudioVisualiserAnimatingView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct AudioVisualiserAnimatingView: View {

    // MARK: - Properties

    @EnvironmentObject var audioVisualiserViewModel: AudioVisualiserViewModel

    // MARK: - View

    var body: some View {
        HStack(spacing: 1) {
            ForEach(0 ..< 75) { item in
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 5, height: .random(in: 25...75))
                    .foregroundColor(.white)
            }
            .animation(.linear(duration: 0.5).repeatForever().speed(1.0), value: audioVisualiserViewModel.isVisualiserRunning)
        }
        .padding(.top, 20)
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    AudioVisualiserAnimatingView()
}

#endif
