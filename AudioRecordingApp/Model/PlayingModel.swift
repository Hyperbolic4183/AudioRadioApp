//
//  PlayingModel.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/10.
//

import Foundation
import RealmSwift

class PlayingModel: Object {
    @objc dynamic var title = ""
    @objc dynamic var path = ""
}
