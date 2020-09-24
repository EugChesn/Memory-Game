//
//  RootViewController.swift
//  GameCard
//
//  Created by Евгений on 24.09.2020.
//  Copyright © 2020 Евгений. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.3463526964, green: 0.6376843452, blue: 0.6900572777, alpha: 1)
        //imageView.cornerRadius()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 1.5, delay: 0.0, options: .transitionFlipFromBottom, animations: {
            self.imageView.alpha = 0.0
            }) { _ in
                self.presentMainView()
            }
        }
    }

    private func presentMainView() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
