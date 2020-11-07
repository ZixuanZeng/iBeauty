//
//  AutoSegue.swift
//  Capstone Project
//
//  Created by Zixuan Zeng on 9/10/20.
//  Copyright © 2020 Zixuan Zeng. All rights reserved.
//

import UIKit

class AutoSegue: UIStoryboardSegue, UIViewControllerTransitioningDelegate {
    
    override func perform() {
        destination.transitioningDelegate = self
        super.perform()
    }
    
    private func animationController(forDismissed dismissed: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AutoPresentAnimator()
    }

}

class AutoPresentAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 3.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: .to)!
        let toView = transitionContext.view(forKey: .to)!
        
        if toView == toView {
            transitionContext.containerView.addSubview(toView)
        }
        
        toView.frame = .zero
        toView.layoutIfNeeded()
        
        let duration = transitionDuration(using: transitionContext)
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        UIView.animate(withDuration: duration, animations: {
            toView.frame  = finalFrame
            toView.layoutIfNeeded()
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
        })
    }
}

