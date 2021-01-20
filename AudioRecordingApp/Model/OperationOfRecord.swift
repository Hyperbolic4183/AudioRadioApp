//
//  RecordingModel.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/02.
//

import UIKit
import AVFoundation
import RealmSwift

class OperationOfRecord: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    var recordPermisson = false
    let audioSession = AVAudioSession.sharedInstance()
    var audioRecoder: AVAudioRecorder!
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
    }
    func setCategoryToRecord() {
        do {
            try audioSession.setCategory(.record, mode: .default, options: [])
        } catch {
            print("setCategoryに失敗した\(error)")
        }
    }
    
    func start() {
        setCategoryToRecord()
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
        
        
        let now = Date()
        
        
        do {
            try fileManager.moveItem(at: atPath, to: toPath)
            realmWrite(title: title, path: lastPathComponent, date: now)
            print("ファイルの移動に成功")
        } catch {
            print("ファイルの移動に失敗\(error)")
        }
    }
    
    func realmWrite(title: String, path: String, date: Date) {
        print("realmWrite")
        
        let audio: PlayingModel = PlayingModel()
        audio.title = title
        audio.path = path
        //audio.date = date
        print("pathは\(path)")
        let realm = try! Realm()
        try! realm.write {
            realm.add(audio)
        }
    }
}



