//
//  LoadingView.swift
//  Tsetatonsisith
//
//  Created by Abdul Sami on 20/09/2018.
//  Copyright © 2018 Abdul Sami. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    static let shared = LoadingView()
    
    var activityIndicatorView : UIActivityIndicatorView?
    
    func show(_ controller: UIViewController) {
        
        if(controller.view.subviews.contains(self)) {
            return
        }
    
        self.frame = controller.view.bounds
        
        if activityIndicatorView == nil {
            activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        }
        
        activityIndicatorView!.center = controller.view.center
        addSubview(activityIndicatorView!)
        controller.view.addSubview(self)
        controller.view.bringSubview(toFront: self)
        activityIndicatorView!.startAnimating()
    }
    
    func hide() {
        guard self.superview != nil else { return }
        removeFromSuperview()
    }

}
