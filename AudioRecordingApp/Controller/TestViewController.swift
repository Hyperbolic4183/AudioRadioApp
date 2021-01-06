//
//  TestViewController.swift
//  AudioRecordingApp
//
//  Created by 大塚周 on 2021/01/04.
//

import UIKit

class TestViewController: UIViewController {

    let label = UILabel()
    var fileName = "新規作成"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLabel()
        print("viewdidload")
    }
    private func setupLabel() {
        label.text = "あいうえお"
        label.backgroundColor = .red
        let size = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
            $0.center.equalToSuperview()
        }
    }
//    //Documetnsの先にフォルダを作成する関数
//    func addFolder(_ folderName: String) {
//        let fileManager = FileManager.default
//        let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let directory = documentDirectoryFileURL.appendingPathComponent(folderName, isDirectory: true)
//        do {
//            try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
//        } catch {
//            print("createDirectoryに失敗した\(error)")
//        }
//    }
//    //Documents/folderNameに含まれるファイルの数を返す関数
//    func countingFiles(_ folderName: String) -> Int? {
//        var pathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        pathString = pathString + "/" + folderName
//        do {
//            return try FileManager.default.contentsOfDirectory(atPath: pathString).count
//        } catch let error {
//            print("contentsOfDirectoryに失敗した\(error)")
//            return nil
//        }
//    }
//    //フォルダ名とファイル名を指定し、Documetnsフォルダに新たに追加する関数
//    func addfileToFolder(_ folderName: String, _ fileName: String) {
//        var pathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        //フォルダを追加する
//        addFolder(folderName)
//        //パスを用意する
//        pathString = "file://" + pathString + "/" + folderName
//        guard let path = URL(string: pathString) else { return }
//        print("テスト: pathは\(path)です")
//        //保存するファイルを用意する
//        let fileName = "\(fileName).mp3"
//        let pathToFile = path.appendingPathComponent(fileName)
//        //内容を用意する
////        let testText = "This is a pen"
////        let data: Data? = testText.data(using: .utf8)
////        guard let textFile = data else { return }
////        //パスに内容を書き込む
////        do {
////            try textFile.write(to: )
////            print("書き込みに成功した")
////        } catch let error {
////            print("書き込みに失敗した\(error)")
////        }
//    }
//    //新規作成nを作成する関数
//    func namingFile() -> String? {
//        var numberOfFiles = 0
//        var fileName = "新規作成"
//        guard let number = countingFiles("Draft") else { return nil }
//        numberOfFiles = number
//        fileName = fileName + String(numberOfFiles+1)
//        return fileName
//    }
//
//    //Documents/Draftフォルダに「新規作成n」(nはファイルの最大数+1)ファイルを追加し、そこまでのURLを返す関数
//    func addFileToDraftFolder() -> URL? {
//        //DocumentsにDraftフォルダを追加
//        addFolder("Draft")
//        //Draftファイルに格納されているファイルの数をもとに名前を設定
//        guard let fileName = namingFile() else { return nil }
//        //Documentsまでのパスを取得
//        let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        //addfileToFolder("Draft", fileName)
//        let url = documentDirectoryFileURL.appendingPathComponent(fileName)
//        print(url)
//        return url
//    }
}
