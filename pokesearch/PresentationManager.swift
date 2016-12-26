//
//  PresentationManager.swift
//  pokesearch
//
//  Created by Marc Cruz on 12/24/16.
//  Copyright © 2016 MarcBits. All rights reserved.
//

import UIKit

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

class PresentationManager: NSObject {

    var direction = PresentationDirection.left
    var disableCompactHeight = false
    
}

// MARK: - UIViewControllerTransitioningDelegate
extension PresentationManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationController = PresentationController(presentedViewController: presented, presenting: presenting, direction: direction)
        
        presentationController.delegate = self
        
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return PresentationAnimator(direction: direction, isPresentation: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            
            return PresentationAnimator(direction: direction, isPresentation: false)
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate
extension PresentationManager: UIAdaptivePresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController,
                                   traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        
        if traitCollection.verticalSizeClass == .compact && disableCompactHeight {
            
            return .overFullScreen
        } else {
            
            return .none
        }
    }
    
    func presentationController(_ controller: UIPresentationController,
                                viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle)
        -> UIViewController? {
            
        guard style == .overFullScreen else { return nil }
            
        // MARK: Research
        return UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "RotateViewController")
    }
    
}
