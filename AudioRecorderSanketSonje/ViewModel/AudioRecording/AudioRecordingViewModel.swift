//
//  AudioRecordingViewModel.swift
//  AudioRecorderSanketSonje
//
//  Created by Sanket Sonje  on 01/06/24.
//

import Foundation
import SwiftUI

/// View model to provide the API's related to the visual effects for the `RecordingView`.
class AudioRecordingViewModel: ObservableObject {

    // MARK: - Properties

    @Published var circleSize: CGFloat = 0.0
    @Published var seconds = 0
    @Published var minutes = 0
    @Published var hours = 0
    @Published var time = "00 : 00 : 00"
    @Published var timeRecord: Timer?
    @Published var opacityRecord: CGFloat = 1.0
    @Published var opacityStop: CGFloat = 0.0
    @Published var opacityWave: CGFloat = 0.5
    @Published var timerWave: Timer?
    @Published var isPaused: Bool = false

    // MARK: - API's

    func animateCircleAfterStartRecoding() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            withAnimation(.spring()) { [weak self] in
                guard let self else {
                    AudioRecorderLogger.sharedInstance.debug("[AudioPlaybackViewModel] self shouldn't be nil")
                    return
                }
                self.updatePropertiesAfterStartRecording(timer: timer)
            }
        }

        updateOpacity()
        updateTimeProperties()
    }

    func animateCircleAfterStopRecoding() {
        resetTimeProperties()
        timeRecord = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            withAnimation(.spring()) { [weak self] in
                guard let self else {
                    AudioRecorderLogger.sharedInstance.debug("[AudioPlaybackViewModel] self shouldn't be nil")
                    return
                }

                self.updatePropertiesAfterStopRecording(timer: timer)
            }
        }
    }

    func updatePropertiesAfterPauseAction() {
        isPaused = true
        timerWave?.invalidate()
        timeRecord?.invalidate()
        self.opacityRecord = 1.0
        self.opacityStop = 1.0
        self.opacityWave = 0.5
    }

    func updatePropertiesAfterResumeAction() {
        isPaused = false
        updateOpacity()
        updateTimeProperties()
    }

    // MARK: - Private Helpers

    private func resetTimeProperties() {
        timerWave?.invalidate()
        timeRecord?.invalidate()
    }

    private func updatePropertiesAfterStartRecording(timer: Timer) {
        circleSize += 250.0
        opacityRecord -= 0.3
        opacityStop -= 0.3

        if circleSize >= (UIScreen.main.bounds.height) {
            opacityRecord = 0.0
            opacityStop = 1.0
            timer.invalidate()
        }
    }

    private func updatePropertiesAfterStopRecording(timer: Timer) {
        circleSize -= 250.0
        opacityRecord += 0.3
        opacityStop += 0.3

        if circleSize <= 0.0 {
            resetProperties(timer: timer)
        }
    }

    private func updateTimeProperties() {
        timeRecord = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self else {
                AudioRecorderLogger.sharedInstance.debug("[AudioPlaybackViewModel] self shouldn't be nil")
                return
            }

            self.seconds += 1

            if self.seconds == 60 {
                self.seconds = 0
                self.minutes += 1
            }

            if self.minutes == 60 {
                self.minutes = 0
                self.hours += 1
            }

            self.time = String(format: "%02d : %02d : %02d", self.hours, self.minutes, self.seconds)

            if hours >= 4 {
                animateCircleAfterStopRecoding()
                return
            }
        }
    }

    private func updateOpacity() {
        timerWave = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { time in
            withAnimation(.spring()) { [weak self] in
                guard let self else {
                    AudioRecorderLogger.sharedInstance.debug("[AudioPlaybackViewModel] self shouldn't be nil")
                    return
                }

                self.opacityWave += 0.1

                if self.opacityWave >= 0.9 {
                    self.opacityWave = 0.5
                }
            }
        }
    }

    private func resetProperties(timer: Timer) {
        opacityRecord = 1.0
        opacityStop = 0.0
        opacityWave = 0.5
        seconds = 0
        minutes = 0
        hours = 0
        time = "00 : 00 : 00"
        isPaused = false
        timer.invalidate()
    }
}
