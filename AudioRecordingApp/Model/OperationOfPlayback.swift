//
//  OperationOfPlayback.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/12.
//

import Foundation
import AVFoundation

class OperationOfPlayback: NSObject, AVAudioPlayerDelegate {
    let notificationCenter = NotificationCenter()
    let fileManager = FileManager.default
    let audioSession = AVAudioSession.sharedInstance()
    var audioPlayer: AVAudioPlayer?
    var audioDuraion: TimeInterval?
    //var isPlaying: Bool = false
    
    init?(fileName: String) {
        super.init()
        
        let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("AudioFile").appendingPathComponent(fileName)
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            self.audioDuraion = audioPlayer?.duration
            audioPlayer?.delegate = self
        } catch {
            audioPlayer = nil
        }
    }
    
    func changeCategoryToPlay() {
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
        } catch {
            print("setCategoryに失敗した\(error)")
        }
    }
    
    func play() {
        do {
            audioPlayer?.play()
            
        } catch {
            print("AVAudioPlayerのインスタンス化失敗した\(error)")
        }
    }
    func pause() {
        audioPlayer?.pause()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if player.currentTime == player.duration {
            print("同じ")
        }
        //通知を送る
        NotificationCenter.default.post(name: .init(rawValue: "audioPlayerDidFinishPlaying"), object: nil)
    }
}
