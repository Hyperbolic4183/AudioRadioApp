//
//  RecordingModel.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/02.
//

import UIKit
import AVFoundation

class RecordingModel: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate{
    var audioRecoder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var lastPathComponent: String!
    
    func audioSession() {
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
    
    func record() {
        print("record")
        var audioRecoder = AVAudioRecorder()
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        guard let url = addFileToDraftFolder() else { return }
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
    
    func stop() {
        print("stop")
        let audioRecoder = AVAudioRecorder()
        audioRecoder.stop()
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
    
    func add() {
        addFolder("AudioFile")
        let fileManager = FileManager.default
        let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let atPath = documentDirectoryFileURL.appendingPathComponent("Draft").appendingPathComponent(lastPathComponent)
        let toPath = documentDirectoryFileURL.appendingPathComponent("AudioFile").appendingPathComponent(lastPathComponent)
        do {
            try fileManager.moveItem(at: atPath, to: toPath)
            print("ファイルの移動に成功")
        } catch {
            print("ファイルの移動に失敗\(error)")
        }
        
    }
    //Documents/folderNameに含まれるファイルの数を返す関数
    func countingFiles(_ folderName: String) -> Int? {
        var pathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        pathString = pathString + "/" + folderName
        do {
            return try FileManager.default.contentsOfDirectory(atPath: pathString).count
        } catch let error {
            print("失敗した\(error)")
            return nil
        }
    }
    //フォルダ名とファイル名を指定し、Documetnsフォルダに新たに追加する関数
    func addfileToFolder(_ folderName: String, _ fileName: String) {
        var pathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        //フォルダを追加する
        addFolder(folderName)
        //パスを用意する
        pathString = "file://" + pathString + "/" + folderName
        guard let path = URL(string: pathString) else { return }
        //保存するファイルを用意する
        let fileName = "\(fileName).txt"
        let textPath = path.appendingPathComponent(fileName)
        //内容を用意する
        let testText = "This is a pen"
        let data: Data? = testText.data(using: .utf8)
        guard let textFile = data else { return }
        //パスに内容を書き込む
        do {
            try textFile.write(to: textPath)
            print("書き込みに成功した")
        } catch let error {
            print("書き込みに失敗した\(error)")
        }
    }
    //新規作成nを作成する関数
    func namingFile() -> String? {
        var numberOfFiles = 0
        var fileName = "新規作成"
        guard let number = countingFiles("Draft") else { return nil }
        numberOfFiles = number
        fileName = fileName + String(numberOfFiles+1)
        return fileName
    }
    
    //Documents/Draftフォルダに「新規作成n」(nはファイルの最大数+1)ファイルを追加し、そこまでのURLを返す関数
    func addFileToDraftFolder() -> URL? {
        //DocumentsにDraftフォルダを追加
        addFolder("Draft")
        //Draftファイルに格納されているファイルの数をもとに名前を設定
        guard let fileName = namingFile() else { return nil }
        //Documentsまでのパスを取得
        let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //addfileToFolder("Draft", fileName)
        let url = documentDirectoryFileURL.appendingPathComponent("Draft").appendingPathComponent(fileName)
        print("urlは\(url)です")
        return url
    }
}



