//
//  AudioRecorderMock.swift
//  AudioRecorderSanketSonjeTests
//
//  Created by Sanket Sonje  on 02/06/24.
//

import Foundation
@testable import AudioRecorderSanketSonje

class AudioRecorderMock: AudioRecordingProtocol {

    // MARK: - Properties

    var state: RecordingState = .stopped

    // MARK: - Shared Instance

    static let sharedInstance = AudioRecorderMock()

    // MARK: - Private Init

    private init() {}

    // MARK: - Delegate Methods

    func startRecording(on date: Date) throws {
        updateRecordingState(with: .recording)
    }
    
    func resumeRecording() throws {
        updateRecordingState(with: .recording)
    }
    
    func pauseRecording() {
        updateRecordingState(with: .paused)
    }
    
    func stopRecording() {
        updateRecordingState(with: .stopped)
    }
    
    func updateRecordingState(with newState: RecordingState) {
        state = newState
    }
}
