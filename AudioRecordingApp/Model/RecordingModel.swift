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
    
    //Documetnsの先にフォルダを作成する関数
    func addFolder(_ folderName: String) {
        let fileManager = FileManager.default
        let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directory = documentDirectoryFileURL.appendingPathComponent(folderName, isDirectory: true)
        do {
            try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("失敗した")
        }
    }
    //Documents/folderNameに含まれるファイルの数を返す関数
    func countFiles(_ folderName: String) -> Int? {
        var pathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        pathString = pathString + "/" + folderName
        do {
            return try FileManager.default.contentsOfDirectory(atPath: pathString).count
        } catch let error {
            print("失敗した\(error)")
            return nil
        }
    }

}



