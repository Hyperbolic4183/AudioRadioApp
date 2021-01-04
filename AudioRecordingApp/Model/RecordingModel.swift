//
//  RecordingModel.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/02.
//

import UIKit
import AVFoundation

struct RecordingModel {
    var audioRecoder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    func record() {
        print("record")
        let audioSession = AVAudioSession.sharedInstance()
        //許可を求めるアラートを表示する
        audioSession.requestRecordPermission { granted in
            if granted {
                print("許可した")
                do {
                    //audioSessionのカテゴリを設定
                    try audioSession.setCategory(.record, mode: .default, options: [])
                } catch {
                    print("audioSessionがカテゴリのセットに失敗した")
                }
            } else {
                print("許可しなかった")
                return
            }
        }
        do {
            try audioSession.setActive(true)
        } catch {
            print("audioSessionのアクティブ可に失敗した")
            return
        }
    }

}



