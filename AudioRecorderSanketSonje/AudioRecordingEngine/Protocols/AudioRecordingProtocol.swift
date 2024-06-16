//
//  AudioRecordingProtocol.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import Foundation

/// Protocol which provides API's to start, resume, pause, stop recording.
public protocol AudioRecordingProtocol {

    func startRecording(on date: Date) throws

    func resumeRecording() throws

    func pauseRecording()

    func stopRecording()

    func updateRecordingState(with: RecordingState)
}
