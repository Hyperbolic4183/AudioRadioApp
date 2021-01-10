//
//  MainViewController.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/10.
//

import UIKit

class MainViewController: UIViewController {

    private(set) var mainview = MainView()
    
    override func loadView() {
        view = mainview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainview.delegate = self
    }
}

extension MainViewController: MainViewDelegate {
    func plusButtonTapped() {
        print("plusButtonTapped")
        let recordingVC = RecordingViewController()
        recordingVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        recordingVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(recordingVC, animated: true, completion: nil)
    }
}
