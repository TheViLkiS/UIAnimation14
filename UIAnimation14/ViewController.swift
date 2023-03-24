//
//  ViewController.swift
//  UIAnimation14
//
//  Created by Дмитрий Гусев on 24.03.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewForAnimation: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        UIView.animate(withDuration: 2.0) {
//            self.viewForAnimation.center = self.view.center
//            self.viewForAnimation.transform = CGAffineTransform(rotationAngle: .pi).scaledBy(x: 0.5, y: 0.5)
//            self.viewForAnimation.alpha = 0
//
//        } completion: { _ in
//
//            UIView.animate(withDuration: 2.0) {
//                self.viewForAnimation.transform = CGAffineTransform(rotationAngle: .pi * 2).scaledBy(x: 1, y: 1)
//                self.viewForAnimation.alpha = 1
//            }
//
//        }
        self.viewForAnimation.frame.origin.x = 0
        UIView.animateKeyframes(withDuration: 2.0, delay: 0, options:  [.calculationModeLinear, .autoreverse, .repeat]) {
            self.viewForAnimation.frame.origin.x = self.view.bounds.width - self.viewForAnimation.bounds.width
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
                self.viewForAnimation.backgroundColor = .blue
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 1) {
                self.viewForAnimation.alpha = 0.2
            }
            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 1) {
                self.viewForAnimation.transform = .init(rotationAngle: .pi)
            }
            
        }


    }


}

