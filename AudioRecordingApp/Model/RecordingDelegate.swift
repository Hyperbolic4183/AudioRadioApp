//
//  RecordingDelegate.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/02.
//

import Foundation

protocol RecordingViewDelegate: class {
    func start()
    func stop()
    func pause()
    func restart()
    func save(title: String)
    func dismiss()
    func play()
}
