//
//  PlayingDelegate.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/20.
//

import Foundation

protocol PlayingDelegate: class {
    func playback()
    func pause()
    func valueChanged()
    func forward10()
    func goback10()
}

