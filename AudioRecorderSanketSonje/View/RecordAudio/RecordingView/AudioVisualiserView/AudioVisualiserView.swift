//
//  AudioVisualiserView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct AudioVisualiserView: View {

    // MARK: - Properties

    @EnvironmentObject var audioVisualiserViewModel: AudioVisualiserViewModel

    // MARK: - View

    var body: some View {
        ZStack {
            if audioVisualiserViewModel.isVisualiserRunning {
                AudioVisualiserAnimatingView().environmentObject(audioVisualiserViewModel)
            }
        }
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    AudioVisualiserView()
}

#endif
