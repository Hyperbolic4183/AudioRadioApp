//
//  MainViewController.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/10.
//

import UIKit

class MainViewController: UIViewController {

    private(set) var mainview = MainView()
    private(set) var audioTableView = AudioTableView()
 
    override func loadView() {
        view = mainview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainview.delegate = self
        navigationItem.title = "オーディオ一覧"
        navigationController?.navigationBar.barTintColor = UIColor(255, 189, 40)
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        mainview.audioTableView.reloadData()
    }
}

extension MainViewController: MainViewDelegate {
    func didSelectedRow(title: String, audioPath: String) {
        let playingVC = PlayingViewController(audioTitle: title, audioPath: audioPath)
        self.navigationController?.pushViewController(playingVC, animated: true)
    }
    
    
    func plusButtonTapped() {
        print("plusButtonTapped")
        let recordingVC = RecordingViewController()
        recordingVC.recordingModel = OperationOfRecord()
        recordingVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        recordingVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(recordingVC, animated: true, completion: nil)
    }
}


