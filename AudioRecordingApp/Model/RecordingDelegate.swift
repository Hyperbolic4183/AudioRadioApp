//
//  RecordingDelegate.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/02.
//

import Foundation

protocol RecordingViewDelegate: class {
    func recording()
    func stop()
}
