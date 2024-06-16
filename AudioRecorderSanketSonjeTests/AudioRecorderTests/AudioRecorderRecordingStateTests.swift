//
//  AudioRecorderRecordingStateTests.swift
//  AudioRecorderSanketSonjeTests
//
//  Created by Sanket Sonje  on 02/06/24.
//

import Foundation
import XCTest

@testable import AudioRecorderSanketSonje

class AudioRecorderRecordingStateTests: XCTestCase {

    func testStartRecording() throws {
        try AudioRecorderMock.sharedInstance.startRecording(on: Date())
        XCTAssertEqual(AudioRecorderMock.sharedInstance.state, RecordingState.recording)
    }

    func testPauseRecording() throws {
        AudioRecorderMock.sharedInstance.pauseRecording()
        XCTAssertEqual(AudioRecorderMock.sharedInstance.state, RecordingState.paused)
    }

    func testResumeRecording() throws {
        try AudioRecorderMock.sharedInstance.resumeRecording()
        XCTAssertEqual(AudioRecorderMock.sharedInstance.state, RecordingState.recording)
    }

    func testStopRecording() throws {
        AudioRecorderMock.sharedInstance.stopRecording()
        XCTAssertEqual(AudioRecorderMock.sharedInstance.state, RecordingState.stopped)
    }
}
