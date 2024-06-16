//
//  AudioPlaybackViewModel.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import AVFoundation
import Foundation

/// View model to provide API's to play and stop audio recorded files.
class AudioPlaybackViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {

    // MARK: - Properties

    @Published var isPlaying: Bool = false
    @Published var newFileName = ""
    @Published var errorMessage = ""

    private var player: AVAudioPlayer?

    // MARK: - API's

    func prepareAudioPlayer(for audio: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: audio, fileTypeHint: AVFileType.caf.rawValue)
            player?.delegate = self
        } catch {
            AudioRecorderLogger.sharedInstance.debug("[AudioPlaybackViewModel] prepareAudioPlayer operation failed with an error: \(error.localizedDescription)")
        }
    }

    func updateFileName(for audio: URL, with newFileName: String) {
        do {
            guard !newFileName.isEmpty else {
                AudioRecorderLogger.sharedInstance.debug("[AudioPlaybackViewModel] New File Name is empty")
                errorMessage = "Please enter file name"
                return
            }

            let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let newFilePath = documentURL.appendingPathComponent(newFileName + ".caf")
            try FileManager.default.moveItem(at: audio, to: newFilePath)
        } catch {
            AudioRecorderLogger.sharedInstance.debug("[AudioPlaybackViewModel] updateFileName operation failed with an error: \(error.localizedDescription)")
        }
    }

    func play() {
        guard let player else {
            AudioRecorderLogger.sharedInstance.debug("[AudioPlaybackViewModel] Player is not created yet")
            return
        }
        isPlaying = true
        player.play()
    }

    func stop() {
        guard let player else {
            AudioRecorderLogger.sharedInstance.debug("[AudioPlaybackViewModel] Player is not created yet")
            return
        }
        isPlaying = false
        player.stop()
    }

    // MARK: - AVAudioPlayerDelegate

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
}
