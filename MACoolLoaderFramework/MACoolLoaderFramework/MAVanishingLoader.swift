//
//  MAVanishingLoader.swift
//  MACoolLoader
//
//  Created by Mahjabin Alam on 2020/08/06.
//  Copyright © 2020 Mahjabin Alam. All rights reserved.
//

import UIKit

public class MAVanishingLoader: BaseUIView {
    
    let loaderLayer = MALoaderLayer(ofType: .hollow, path: nil)
    
    public var loaderColor: UIColor = Defaults.strokeColor{
        didSet{
            configureLoaderLayer()
        }
    }
    public var layerWidth: CGFloat = Defaults.strokeWidth{
        didSet{
            configureLoaderLayer()
        }
    }
    
    public var animationframeDuration = 0.15
    var totalDuration = 0.0
    
    var layerPaths: [CGPath]{
        var pathList = [CGPath]()
        var multiplier : CGFloat = 0.2
        for _ in 0..<7 {
            if let path = getPathForLayer(withMultiplier: multiplier){
                pathList.append(path.cgPath)
                multiplier += 0.10
            }
        }
        return pathList
    }
    var initialPath: CGPath{
        if layerPaths.count > 0 {
            return layerPaths[0]
        }
        return UIBezierPath().cgPath
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override init(onView view: UIView, withSize size: LoaderSize?) {
        super.init(onView: view, withSize: size)
        configureLoaderLayer()
        self.layer.addSublayer(loaderLayer)
    }
    
    func configureLoaderLayer(){
        loaderLayer.fillColor = UIColor.clear.cgColor
        loaderLayer.strokeColor = loaderColor.cgColor
        loaderLayer.lineWidth = layerWidth
        loaderLayer.path = initialPath
        loaderLayer.add(keyFrameAnimation, forKey: "vanishingGroupAnimation")
    }
    
    var keyFrameTimes: [NSNumber]{
        var timeArray = [NSNumber]()
        var startingTime = -animationframeDuration
        
        for _ in 0..<layerPaths.count {
            startingTime += animationframeDuration
            timeArray.append(NSNumber(value: startingTime))
        }
        totalDuration = startingTime + animationframeDuration
        return timeArray
    }
    
    var keyFrameAnimation: CAKeyframeAnimation{
        let animation = CAKeyframeAnimation(keyPath: "path")
        animation.values = layerPaths
        animation.keyTimes = keyFrameTimes
        animation.duration = totalDuration
        animation.repeatCount = .greatestFiniteMagnitude
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = true
        return animation
        
    }
    
    var fadingAnimation: CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = animationframeDuration
        return animation
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if let view = parentView{
            loaderLayer.position = view.center
        }
    }
}
