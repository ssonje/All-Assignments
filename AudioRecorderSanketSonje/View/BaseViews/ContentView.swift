//
//  ContentView.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 31/05/24.
//

import SwiftUI

struct ContentView: View {

    // MARK: - View

    var body: some View {
        TabView {
            RecordAudioView()
                .tabItem {
                    Image(systemName: "record.circle")
                    Text("Record")
                }

            AudioFilesView()
                .tabItem {
                    Image(systemName: "folder")
                    Text("Audio Files")
                }
        }
        .accentColor(.blue)
    }
}

// MARK: - Preview

#if DEBUG

#Preview {
    ContentView()
}

#endif
