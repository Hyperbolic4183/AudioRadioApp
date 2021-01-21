//
//  MainViewDelegate.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/20.
//

import Foundation
protocol MainViewDelegate: AnyObject {
    func plusButtonTapped()
    func didSelectedRow(title: String, audioPath: String)
}
