//
//  PlayingDelegate.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/20.
//

import Foundation

protocol PlayingDelegate: AnyObject {
    func playback()
    func pause()
    func valueOfSliderChanged()
    func forward10()
    func goback10()
}

