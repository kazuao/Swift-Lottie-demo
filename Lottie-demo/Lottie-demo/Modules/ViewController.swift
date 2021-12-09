//
//  ViewController.swift
//  Lottie-demo
//
//  Created by kazunori.aoki on 2021/12/08.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    // MARK: UI
    @IBOutlet weak var openButton: UIButton!


    // MARK: Property
    var animationView: AnimationView?


    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        animationView = .init(name: "coffee")
        animationView?.frame = view.bounds
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 0.5
        view.addSubview(animationView!)

        animationView?.play()
        view.sendSubviewToBack(animationView!)
    }


    // MARK: IBAction
    @IBAction func tapOpenButton(_ sender: Any) {
        let viewController = DownloadViewController(nibName: "DownloadViewController", bundle: nil)
        present(viewController, animated: true)
    }

}

