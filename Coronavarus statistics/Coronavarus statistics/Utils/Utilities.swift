//
//  Utilities.swift
//  Coronavarus statistics
//
//  Created by David on 1/1/21.
//

import UIKit

class Utilities {
    
    func loadingView() -> UIView {
        let loadingOverlay = UIView()
        loadingOverlay.contentMode = .scaleAspectFit
        loadingOverlay.backgroundColor = UIColor.black
        loadingOverlay.alpha = 0.5
        loadingOverlay.isUserInteractionEnabled = true
        loadingOverlay.layer.zPosition = 1
        
        let loadingLayer = CAReplicatorLayer()
        loadingLayer.frame = CGRect(x: -10, y: 0, width: 100, height: 10)
        let circle = CALayer()
        circle.frame = CGRect(x: -10, y: 0, width: 10, height: 10)
        circle.backgroundColor = UIColor.gray.cgColor
        circle.cornerRadius = 10 / 2
        loadingLayer.addSublayer(circle)
        loadingLayer.instanceCount = 3
        loadingLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)
        let anim = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        anim.fromValue = 1.0
        anim.toValue = 0.2
        anim.duration = 1
        anim.repeatCount = .infinity
        circle.add(anim, forKey: nil)
        loadingLayer.instanceDelay = anim.duration / Double(loadingLayer.instanceCount)
        
        let v = UIView()
        v.layer.addSublayer(loadingLayer)
        loadingOverlay.addSubview(v)
        v.center(inView: loadingOverlay)

        return loadingOverlay
    }
}
