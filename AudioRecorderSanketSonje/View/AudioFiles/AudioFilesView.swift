//
//  AudioFilesView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import SwiftUI

struct AudioFilesView: View {

    // MARK: - Properties

    @StateObject var audioFilesViewModel = AudioFilesViewModel()

    // MARK: - View

    var body: some View {
        ZStack {
            AudioFilesListView().environmentObject(audioFilesViewModel)
        }
        .onAppear(perform: audioFilesViewModel.updateAudios)
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    AudioFilesView()
}

#endif
