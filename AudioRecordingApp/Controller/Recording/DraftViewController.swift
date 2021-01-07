//
//  DraftViewController.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/07.
//

import UIKit

class DraftViewController: UIViewController {
    
    private(set) var draftView = DraftView()
    override func loadView() {
        view = draftView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        draftView.delegate = self
    }
}

extension DraftViewController: DraftViewDelegate {
    func dissmiss() {
        print("dismiss")
        self.dismiss(animated: true, completion: nil)
    }
}
