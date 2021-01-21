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
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        guard let url = fileManagerOperate.addFileToDraftFolder() else { return }
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
        audioRecoder.pause()
    }
    
    func restart() {
        audioRecoder.record()
    }
    
    func stop() {
        audioRecoder.stop()
        
        do {
            try audioSession.setActive(false)
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
        } catch {
            print("ファイルの移動に失敗\(error)")
        }
    }
    
    func realmWrite(title: String, path: String, date: Date) {
        print("realmWrite")
        
        let audio: AudioMemo = AudioMemo()
        audio.title = title
        audio.audioFilepath = path
        let realm = try! Realm()
        try! realm.write {
            realm.add(audio)
        }
    }
}



