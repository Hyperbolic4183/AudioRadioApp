//
//  Audio.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/10.
//

import UIKit
import RealmSwift



class AudioTableView: UITableView{
    var realm: Realm?
    var audioArray: Results<AudioMemo>? 
    weak var audioTableViewDelegate: AudioTableViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        delegate = self
        dataSource = self
        register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        backgroundColor = UIColor(15,53,74)
        separatorColor = .clear
        setupRealm()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRealm() {
        do {
            try realm = Realm()
            setupAudioArray()
        } catch {
            print("realmのインスタンス化に失敗")
        }
    }
    
    private func setupAudioArray() {
        do {
            audioArray = try Realm().objects(AudioMemo.self).sorted(byKeyPath: "date", ascending: false)
        } catch {
            print("audioArrayへのオブジェクトの代入に失敗")
        }
    }
}

extension AudioTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        audioArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let audio: AudioMemo = audioArray?[indexPath.row] ?? AudioMemo()
        cell.titleLabel.text = audio.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playingModel = audioArray?[indexPath.row] ?? AudioMemo()
        let title = playingModel.title
        let path = playingModel.audioFilepath
        audioTableViewDelegate?.didSelectedRow(title: title, audioPath: path)
    }
}

