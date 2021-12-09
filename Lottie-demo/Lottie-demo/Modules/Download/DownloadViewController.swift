//
//  DownloadViewController.swift
//  Lottie-demo
//
//  Created by kazunori.aoki on 2021/12/08.
//

import UIKit
import Lottie

enum DownloadKeyFrames: CGFloat {
    case startProgress = 140 // 始まり
    case endProgress = 188   // 終わり
    case completion  = 240   // animationの終わり
}

class DownloadViewController: UIViewController {

    // MARK: UI
    @IBOutlet weak var progressAnimationView: AnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        progressAnimationView.backgroundColor = .clear

        startProgress()
    }

    private func startProgress() {
        // 始まりと終わりを指定できる
        progressAnimationView.play(fromFrame: 0,
                                   toFrame: DownloadKeyFrames.startProgress.rawValue,
                                   loopMode: .none) { [weak self] _ in
            self?.download()
        }
    }

//    private func startDownload() {
//        progressAnimationView.play(fromFrame: DownloadKeyFrames.startProgress.rawValue,
//                                   toFrame: DownloadKeyFrames.endProgress.rawValue,
//                                   loopMode: .none) { [weak self] _ in
//            self?.endProgress()
//        }
//    }

    private func endProgress() {
        progressAnimationView.play(fromFrame: DownloadKeyFrames.endProgress.rawValue,
                                   toFrame: DownloadKeyFrames.completion.rawValue,
                                   loopMode: .none) { _ in

        }
    }

    private func progress(to progress: CGFloat) {
        // 再生範囲の数値を取得
        let progressRange =
        DownloadKeyFrames.endProgress.rawValue - DownloadKeyFrames.startProgress.rawValue

        let progressFrame = progressRange * progress
        let currentFrame = progressFrame + DownloadKeyFrames.startProgress.rawValue

        progressAnimationView.currentFrame = currentFrame
    }
}

extension DownloadViewController: URLSessionDownloadDelegate {

    private func download() {
        let url = URL(string: "https://archive.org/download/SampleVideo1280x720mb/SampleVideo_1280x720_5mb.mp4")!

        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let session = URLSession(configuration: configuration,
                                 delegate: self,
                                 delegateQueue: operationQueue)

        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }

    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64)
    {
        let percentDownloaded = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        print(totalBytesWritten)
        print(totalBytesExpectedToWrite)
        print(percentDownloaded)

        DispatchQueue.main.async {
            self.progress(to: percentDownloaded)
        }
    }

    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL)
    {
        DispatchQueue.main.async {
            self.endProgress()
        }
    }
}
