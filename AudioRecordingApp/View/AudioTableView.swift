//
//  Audio.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/10.
//

import UIKit
import RealmSwift

protocol AudioTableViewDelegate: class {
    func didSelectedRow(title: String, audioPath: String)
}

class AudioTableView: UITableView{
    var realm: Realm?
    var audioArray: Results<PlayingModel>?
    weak var audioTableViewDelegate: AudioTableViewDelegate?
    
    override init(frame: CGRect, style: UITableView.Style) {
        print("init")
        super.init(frame: frame, style: .plain)
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
            print("realmのインスタンス化に成功")
            setupAudioArray()
        } catch {
            print("realmのインスタンス化に失敗")
        }
    }
    
    private func setupAudioArray() {
        do {
            audioArray = try Realm().objects(PlayingModel.self).sorted(byKeyPath: "date", ascending: false)
            print("audioArrayへのオブジェクトの代入に成功")
        } catch {
            print("audioArrayへのオブジェクトの代入に失敗")
        }
    }
}

extension AudioTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let audio: PlayingModel = audioArray?[indexPath.row] ?? PlayingModel()
        cell.titleLabel.text = audio.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let playingModel = audioArray?[indexPath.row] ?? PlayingModel()
        let title = playingModel.title
        let path = playingModel.path
        audioTableViewDelegate?.didSelectedRow(title: title, audioPath: path)
    }
}

