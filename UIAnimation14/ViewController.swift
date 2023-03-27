//
//  ViewController.swift
//  UIAnimation14
//
//  Created by Дмитрий Гусев on 24.03.2023.
//

import UIKit

enum AnimationState {
    case open
    case close
    
}

class ViewController: UIViewController {
    
    var state: AnimationState = .close // статус анимации

    @IBOutlet weak var viewForAnimation: UIView!
    
    @IBOutlet weak var viewCenterYConstraint: NSLayoutConstraint!
    
    var animator: UIViewPropertyAnimator! // chapter 5
    
    @IBOutlet weak var didSlide: UISlider!//chapter 5
    //chapter 5
    @IBAction func didSlideAction(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value) / 100
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        // 3 chapter animation constraint
//
//        self.viewCenterYConstraint.constant = 0
//        UIView.animate(withDuration: 2.0) {
//            //ставит флаг на обновление вьюхи(констраинты)
//            self.view.setNeedsLayout()
//            // обновляет вьюху и внутренние вью(констраинты)
//            self.view.layoutIfNeeded()
            
//        }
        
        
        
        
//1 chapter
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
        
        // 2 chapter
//        self.viewForAnimation.frame.origin.x = 0
//        UIView.animateKeyframes(withDuration: 2.0, delay: 0, options:  [.calculationModeLinear, .autoreverse, .repeat]) {
//            self.viewForAnimation.frame.origin.x = self.view.bounds.width - self.viewForAnimation.bounds.width
//
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
//                self.viewForAnimation.backgroundColor = .blue
//            }
//
//            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 1) {
//                self.viewForAnimation.alpha = 0.2
//            }
//            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 1) {
//                self.viewForAnimation.transform = .init(rotationAngle: .pi)
//            }
//
//        }
        
        
            // 4 chapter
//        self.viewForAnimation.frame.origin.x = 0
//
//        UIView.animate(withDuration: 2.5, //продолжительность анимации
//                       delay: 0.1,        // задержка перед анимацией
//                       usingSpringWithDamping: 0.8, //отскок(затухание объекта) 1 - обычное меньше - отскок
//                       initialSpringVelocity: 1.0, // начальная скорость запуска 1 - быстрый, 0 - слабый
//                       options: [.curveEaseInOut, .autoreverse, .repeat]) {
//
//            self.viewForAnimation.frame.origin.x = self.view.bounds.maxX - self.viewForAnimation.frame.width - 20
//
//        }
        
        
        
        //chapter 5 propertyAnimated
        
        viewForAnimation.center = view.center
        
//        let layer = viewForAnimation.layer
//        print("Delegate \(layer.delegate), \(viewForAnimation)")
//
        
        animator = UIViewPropertyAnimator(duration: 1.5, curve: .easeInOut, animations: {
            self.viewForAnimation.transform = .init(scaleX: 1.5, y: 1.5)
            self.viewForAnimation.backgroundColor = .blue
            self.viewForAnimation.layer.cornerRadius = 30
        })
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
//        viewForAnimation.addGestureRecognizer(tapGesture)
//
//        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
//        viewForAnimation.addGestureRecognizer(tapGesture2)
//        tapGesture2.numberOfTapsRequired = 2
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        viewForAnimation.addGestureRecognizer(panGesture)

    }
    @objc func didPan(_ panGesture: UIPanGestureRecognizer) {
        
        let final = (view.bounds.height - viewForAnimation.bounds.height) / 2
        let translation = panGesture.translation(in: self.view)
        
        
        switch panGesture.state {
            
//        case .possible: // возможен
//            <#code#>
        case .began: // начался
            activateAnimation()
            animator.pauseAnimation()
        case .changed: // изменился
            animator.fractionComplete = translation.y / final
        case .ended: //завершился
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
//        case .cancelled: //отменен жест(пришел звонок)
//            <#code#>

         default:
            break
        }
        
        
        
//        let newPosition = panGesture.translation(in: self.view) // позиция окончания жеста
        
//        let currentX = viewForAnimation.center.x
//        let currentY = viewForAnimation.center.y
        
        
//
//        viewForAnimation.center = CGPoint(x: currentX + newPosition.x, y: currentY + newPosition.y)
//        animator.fractionComplete = viewForAnimation.frame.origin.y / final
        
//        panGesture.setTranslation(.zero, in: self.view)
        
    }
    
    func activateAnimation() {
        switch state {
        case .open:
            didTap()
        case .close:
            didDoubleTap()
        }
    }
    
    
    
    @objc func didTap() {
        
        
        
        animator.addAnimations {
            self.viewForAnimation.transform = .init(scaleX: 1.5, y: 1.5)
            self.viewForAnimation.backgroundColor = .blue
            self.viewForAnimation.layer.cornerRadius = 30
        }
        
        animator.addCompletion { position in
            print("Animation Complete \(position) ")
            self.state = .close
            
        }
        
        animator.startAnimation()
//        if animator.fractionComplete == 1 {
//            animator.fractionComplete = 0
//            return
//        }
//        animator.fractionComplete += 0.1
//
    }
    
    @objc func didDoubleTap() {
        
        animator.addAnimations {
            self.viewForAnimation.transform = .identity
            self.viewForAnimation.backgroundColor = .systemPink
            self.viewForAnimation.layer.cornerRadius = 0        }
        
        animator.addCompletion { position in
            print("Animation Complete \(position) ")
            self.state = .open
            
        }

        
        animator.startAnimation()
//        if animator.fractionComplete == 1 {
//            animator.fractionComplete = 0
//            return
//        }
//        animator.fractionComplete += 0.1
//
    }

    override func viewDidAppear(_ animated: Bool) {
//        animator.startAnimation()
        
    }

}

