//
//  PlayingModel.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/10.
//

import Foundation
import RealmSwift

class AudioMemo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var audioFilepath: String = ""
    @objc dynamic var date: Date = Date()
}
