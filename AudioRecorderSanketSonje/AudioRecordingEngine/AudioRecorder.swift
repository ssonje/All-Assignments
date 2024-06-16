//
//  AudioRecorder.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import Foundation
import AVFoundation

/// This class provides the various APis to start, pause, resume and stop the audio recording.
/// Following is the architecture of the AudioRecorder class.
/// We are using custom node to do operation so that we can keep the main mixer node free.
/*
 ||----------------------------------------------------------------------------------------------------------||
 ||                                                                                                          ||
 ||  AVAudioInputMode  -->  AVAudioMixerNode (Custom)  -->  AVAudioMixerNode (Main)  -->  AVAudioOutputMode  ||
 ||                                                                                                          ||
 ||----------------------------------------------------------------------------------------------------------||
 */
class AudioRecorder: AudioRecordingProtocol {

    // MARK: - Shared Instance

    public static let sharedInstance = AudioRecorder()

    // MARK: - Properties

    private var audioEngine: AVAudioEngine
    private var customAudioMixerNode: AVAudioMixerNode
    private let semaphore = DispatchSemaphore(value: 1)
    var state: RecordingState = .stopped

    // MARK: - Private Init

    private init() {
        audioEngine = AVAudioEngine()
        customAudioMixerNode = AVAudioMixerNode()

        // Setup Session and Engine
        setupSessionAndEngine()
    }

    // MARK: - Protocol Methods

    func startRecording(on date: Date) throws {
        // Lock the resources
        semaphore.wait()

        // Setup audio node
        let audioNode: AVAudioNode = customAudioMixerNode
        let format = audioNode.outputFormat(forBus: 0)

        // Setup document URL to save the audio
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print(documentURL)
        let fileName = getFileName(on: date)
        let file = try AVAudioFile(forWriting: documentURL.appendingPathComponent(fileName), settings: format.settings)

        audioNode.installTap(onBus: 0, bufferSize: 4096, format: format, block: {
            (buffer, time) in
            try? file.write(from: buffer)
        })

        try audioEngine.start()
        updateRecordingState(with: .recording)

        // Unlock the resources
        semaphore.signal()
    }

    func resumeRecording() throws {
        // Lock the resources
        semaphore.wait()

        try audioEngine.start()
        updateRecordingState(with: .recording)

        // Unlock the resources
        semaphore.signal()
    }

    func pauseRecording() {
        // Lock the resources
        semaphore.wait()

        audioEngine.pause()
        updateRecordingState(with: .paused)

        // Unlock the resources
        semaphore.signal()
    }

    func stopRecording() {
        // Lock the resources
        semaphore.wait()

        // Remove existing taps on nodes
        customAudioMixerNode.removeTap(onBus: 0)

        audioEngine.stop()
        updateRecordingState(with: .stopped)

        // Unlock the resources
        semaphore.signal()
    }

    func updateRecordingState(with newState: RecordingState) {
        state = newState
    }

    // MARK: - Private Helpers

    private func setupSessionAndEngine() {
        // Setup audio session
        setupSession()

        // Setup audio engine
        setupEngine()
    }

    private func setupSession() {
        // Setup and activate session for recording an audio
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.record)
        try? session.setActive(true, options: .notifyOthersOnDeactivation)
    }

    private func setupEngine() {
        // Set volume to 0 to avoid audio feedback while recording
        customAudioMixerNode.volume = 0

        // Attach the custom audio mixer node to the audio engine
        audioEngine.attach(customAudioMixerNode)

        // Make required connections
        makeConnections()

        // In order for the system to allocate the necessary resources, prepare the engine in advance.
        audioEngine.prepare()
    }

    private func makeConnections() {
        /*
         ||----------------------------------------------------||
         ||                                                    ||
         ||  AVAudioInputMode  -->  AVAudioMixerNode (Custom)  ||
         ||                                                    ||
         ||----------------------------------------------------||
         */
        // Get AVAudioInputMode and connect it to the custom AVAudioMixerNode
        let audioInputNode = audioEngine.inputNode
        let audioInputFormat = audioInputNode.outputFormat(forBus: 0)

        // Connect audio input node to the custom audio mixer node
        audioEngine.connect(audioInputNode, to: customAudioMixerNode, format: audioInputFormat)

        /*
         ||-----------------------------------------------------------||
         ||                                                           ||
         ||  AVAudioMixerNode (Custom)  -->  AVAudioMixerNode (Main)  ||
         ||                                                           ||
         ||-----------------------------------------------------------||
         */
        // Get main AVAudioMixerNode and connect custom AVAudioMixerNode to the main AVAudioMixerNode
        let mainAudioMixerNode = audioEngine.mainMixerNode
        let mixerFormat = AVAudioFormat(
            commonFormat: .pcmFormatFloat32,
            sampleRate: audioInputFormat.sampleRate,
            channels: 1,
            interleaved: false)

        // Connect custom audio input node to the main audio mixer node
        audioEngine.connect(customAudioMixerNode, to: mainAudioMixerNode, format: mixerFormat)
    }

    private func getFileName(on date: Date) -> String {
        // AVAudioFile uses the Core Audio Format to write to the disk
        /*
         if your you're saving file on 1st June 2024 at 08:18:57 AM
         then your name will be `Recording_on_6_1_24_at_8_18_57_AM.caf`.
         */
        var fileName = "Recording on "
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .medium
        fileName = fileName + dateFormatter.string(from: date)
        fileName = fileName.replacingOccurrences(of: ",", with: " at") + ".caf"
        fileName = fileName.replacingOccurrences(of: " ", with: "_")
        fileName = fileName.replacingOccurrences(of: "/", with: "_")
        fileName = fileName.replacingOccurrences(of: ":", with: "_")
        return fileName
    }
}

#if DEBUG

extension AudioRecorder {

    func getFileNameForTesting(on date: Date) -> String {
        return getFileName(on: date)
    }
}

#endif
