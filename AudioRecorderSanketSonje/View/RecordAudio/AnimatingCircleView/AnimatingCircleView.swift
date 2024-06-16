//
//  AnimatingCircleView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct AnimatingCircleView: View {
    
    // MARK: - Properties

    @EnvironmentObject var viewModel: AudioRecordingViewModel

    // MARK: - View

    var body: some View {
        VStack {
            Spacer()
            Circle()
                .fill(.blue)
                .frame(width: viewModel.circleSize, height: viewModel.circleSize)
                .offset(y: -200)
        }
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    AnimatingCircleView()
}

#endif
