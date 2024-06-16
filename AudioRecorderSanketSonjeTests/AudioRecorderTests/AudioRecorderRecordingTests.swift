//
//  AudioRecorderRecordingTests.swift
//  AudioRecorderSanketSonjeTests
//
//  Created by Sanket Sonje  on 02/06/24.
//

import Foundation
import XCTest

@testable import AudioRecorderSanketSonje

class AudioRecorderRecordingTests: XCTestCase {

    // MARK: - Properties

    private static let date = Date()
    private let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private let fileName = AudioRecorder.sharedInstance.getFileNameForTesting(on: date)

    // MARK: - Tests

    func testActualRecordingFlow() throws {
        // Start recording
        try AudioRecorder.sharedInstance.startRecording(on: Self.date)
        XCTAssertEqual(AudioRecorder.sharedInstance.state, RecordingState.recording)

        // Pause recording
        AudioRecorder.sharedInstance.pauseRecording()
        XCTAssertEqual(AudioRecorder.sharedInstance.state, RecordingState.paused)

        // Resume recording
        try AudioRecorder.sharedInstance.resumeRecording()
        XCTAssertEqual(AudioRecorder.sharedInstance.state, RecordingState.recording)

        // Stop recording
        AudioRecorder.sharedInstance.stopRecording()
        XCTAssertEqual(AudioRecorder.sharedInstance.state, RecordingState.stopped)

        // Get audios
        let audios = try FileManager.default.contentsOfDirectory(at: documentURL, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)

        // Verify Expectation
        let expectation = XCTestExpectation(description: "Core Audio Recording must be created at: \(documentURL)")
        for audio in audios {
            if audio.lastPathComponent == fileName {
                expectation.fulfill()

                // Once the expectation is fulfil, removed the recorded file
                try FileManager.default.removeItem(at: documentURL.appendingPathComponent(fileName))
            }
        }

        // Wait for 5 seconds to full the expectation
        wait(for: [expectation], timeout: 5.0)
    }
}
