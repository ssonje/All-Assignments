//
//  AudioFilesViewModel.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import Foundation

/// View model to provide the API's related audio recordings saved in the app data.
class AudioFilesViewModel: ObservableObject {

    // MARK: - Properties

    @Published var audios: [URL] = []

    // MARK: - API's

    func updateAudios() {
        do {
            let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let audios = try FileManager.default.contentsOfDirectory(at: documentURL, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            self.audios = audios.filter { $0.absoluteString.contains(".caf") }
        } catch {
            AudioRecorderLogger.sharedInstance.debug("[AudioFilesViewModel] Failed to get URLs of audio with error: \(error.localizedDescription)")
        }
    }
}
