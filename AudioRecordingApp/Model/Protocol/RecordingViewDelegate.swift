//
//  RecordingDelegate.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/02.
//

import Foundation

protocol RecordingViewDelegate: AnyObject {
    func start()
    func stop()
    func recordPause()
    func restart()
    func save(title: String)
    func dismiss()
}
