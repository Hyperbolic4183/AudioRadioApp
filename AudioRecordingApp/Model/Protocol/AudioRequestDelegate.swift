//
//  AudioRequestDelegate.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/18.
//

import Foundation
protocol AudioRequestDelegate: AnyObject {
    func requestPermission()
    func showPermissionChangeAlert()
    func authorized()
}
