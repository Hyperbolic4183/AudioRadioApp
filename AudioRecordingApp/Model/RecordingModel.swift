//
//  RecordingModel.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/02.
//

import UIKit
import AVFoundation
import RealmSwift

class RecordingModel: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate{
    
    let audioSession = AVAudioSession.sharedInstance()
    var audioRecoder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var lastPathComponent: String!
    var fileManagerOperate = FileManagerOperate()
    var audioURL: URL?

    func requestRecord() {
        //許可を求めるアラートを表示する
        audioSession.requestRecordPermission { granted in
            if granted {
                print("許可した")
                do {
                    //audioSessionのカテゴリを設定
                    try self.audioSession.setCategory(.record, mode: .default, options: [])
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
    
    func changeCategoryToPlay() {
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
        } catch {
            print("setCategoryに失敗した\(error)")
        }
    }
    
    func start() {
        requestRecord()
        print("start")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        guard let url = fileManagerOperate.addFileToDraftFolder() else { return }
        print("urlは\(url) from start()")
        audioURL = url
        do {
            audioRecoder = try AVAudioRecorder(url: url, settings: settings)
            print("avaudioRecoderのインスタンス化に成功")
            print("audioRecoderは\(audioRecoder)です")
        } catch {
            print("AVAudioRecoderのインスタンス化に失敗\(error)")
        }
        audioRecoder.delegate = self
        audioRecoder.record()
        lastPathComponent = url.lastPathComponent
    }
    
    func pause() {
        print("pause")
        audioRecoder.pause()
    }
    
    func restart() {
        print("restart")
        audioRecoder.record()
    }
    
    func stop() {
        print("stop")
        audioRecoder.stop()
        do {
            try audioSession.setActive(false)
            print("setAvtiveに成功した")
        } catch {
            print("setActiveに失敗した\(error)")
        }
    }
    
    func save(title: String) {
        print("add")
        fileManagerOperate.addFolder("AudioFile")
        let fileManager = FileManager.default
        let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let atPath = documentDirectoryFileURL.appendingPathComponent("Draft").appendingPathComponent(lastPathComponent)
        let toPath = documentDirectoryFileURL.appendingPathComponent("AudioFile").appendingPathComponent(lastPathComponent)
        do {
            try fileManager.moveItem(at: atPath, to: toPath)
            realmWrite(title: title, path: lastPathComponent)
            print("ファイルの移動に成功")
        } catch {
            print("ファイルの移動に失敗\(error)")
        }
    }
    
    func play() {
        print("play")
        changeCategoryToPlay()
        guard let url = audioURL else { return }
        print("urlは\(url) from play()")
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print("AVAudioPlayerのインスタンス化失敗した\(error)")
        }
    }
    
    func realmWrite(title: String, path: String) {
        print("realmWrite")
        let audio: PlayingModel = PlayingModel()
        audio.title = title
        audio.path = path
        print("pathは\(path)")
        let realm = try! Realm()
        try! realm.write {
            realm.add(audio)
        }
    }
}

class OperationOfPlayback {
    let fileManager = FileManager.default
    let audioSession = AVAudioSession.sharedInstance()
    var audioPlayer: AVAudioPlayer!
    
    func changeCategoryToPlay() {
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
        } catch {
            print("setCategoryに失敗した\(error)")
        }
    }
    
    func play(audioName: String) {
        print("play")
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("AudioFile").appendingPathComponent(audioName)
        print("urlは\(url) from play()")
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print("AVAudioPlayerのインスタンス化失敗した\(error)")
        }
    }
}
