//
//  MATranslucentLoader.swift
//  MACoolLoader
//
//  Created by Mahjabin Alam on 2020/08/10.
//  Copyright © 2020 Mahjabin Alam. All rights reserved.
//

import UIKit

public class MATranslucentLoader: BaseUIView {
    
    let expandandleLayer = MALoaderLayer(ofType: .solid, path: nil)
    let circulatingLayer = MALoaderLayer(ofType: .hollow, path: nil)
    
    public var loaderColor:UIColor = UIColor.systemBlue{
        didSet{
            configureLoaders()
        }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override init(onView view: UIView, withSize size: LoaderSize?) {
        super.init(onView: view, withSize: size)
        configureLoaders()
        self.layer.addSublayer(circulatingLayer)
        self.layer.addSublayer(expandandleLayer)
    }
    
    func configureLoaders(){
        if let path = getPathForLayer(){
            configureCirculatingLayer()
            circulatingLayer.setPath(path)
        }
        if let path = getPathForCirculatingLayer(withMultiplier: 0.5){
            configureExpandingLayer()
            expandandleLayer.setPath(path)
        }
    }
    
    func configureCirculatingLayer() {
        circulatingLayer.layerLineWith = 15.0
        circulatingLayer.layerStrokeColor = loaderColor
        circulatingLayer.add(circulatingLayerAnimationGroup, forKey: nil)
    }
    
    func configureExpandingLayer() {
        expandandleLayer.layerLineWith = 15.0
        expandandleLayer.layerStrokeColor = loaderColor
        expandandleLayer.layerFillColor = loaderColor
        expandandleLayer.add(zoomOutAnimation, forKey: nil)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if let center = parenViewCenter{
            circulatingLayer.position = center
            expandandleLayer.position = center
        }
    }
    
    func getPathForCirculatingLayer(withMultiplier multiplier: CGFloat = 1.0 )->UIBezierPath?{
        if let frame = parentView?.frame{
            let adjustableRadius = getAdjustableRadius(forSuperViewFrame: frame) * multiplier
            let path : UIBezierPath?
            
            let offset = getAdjustableLineWidth(forFrame: frame)
            path = UIBezierPath(arcCenter: .zero , radius: (adjustableRadius + offset), startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi , clockwise: true)
            return path
        }
        return nil
    }
    
    var strokeEndAnimation : CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.5
        animation.repeatCount = .greatestFiniteMagnitude
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
    
    var circulatingLayerAnimationGroup: CAAnimationGroup{
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [strokeEndAnimation, fadeInAnimation]
        animationGroup.duration = 1.5
        animationGroup.repeatCount = .greatestFiniteMagnitude
        return animationGroup
    }
   
    
    var zoomOutAnimation: CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.5
        animation.toValue = 1.0
        animation.duration = 1.5
        animation.repeatCount = .greatestFiniteMagnitude
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = true
        return animation
    }
    var fadeInAnimation: CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.repeatCount = .greatestFiniteMagnitude
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
    
}
