//
//  AudioListTableViewController.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/01.
//

import UIKit

class AudioListTableViewController: UITableViewController {
    override func viewDidLoad() {
        print("viewDidLoad")
        tableView.delegate = self
        tableView.dataSource = self
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTapped))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func addBarButtonTapped() {
        let recordingVC = RecordingViewController()
        recordingVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        recordingVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.navigationController?.pushViewController(recordingVC, animated: true)
    }
}
