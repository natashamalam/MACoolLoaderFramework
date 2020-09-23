//
//  MAWavingBlobLoader.swift
//  MACoolLoader
//
//  Created by Mahjabin Alam on 2020/08/10.
//  Copyright © 2020 Mahjabin Alam. All rights reserved.
//

import UIKit

public class MAWavingBlobLoader: BaseUIView {
    
    var containerView : UIView = UIView(frame:.zero)
    public var blobColor = UIColor.systemBlue{
        didSet{
            configureBlobs()
        }
    }
    
    var firstBlob = MALoaderLayer(ofType: .solid, path: nil)
    var secondBlob = MALoaderLayer(ofType: .solid, path: nil)
    var thirdBlob = MALoaderLayer(ofType: .solid, path: nil)
    
    var blobRadius: CGFloat = 0.0
    
    var firstPoint : CGPoint {
        let blobSpacing = containerView.frame.width/4
        return CGPoint(x: containerView.bounds.midX - blobSpacing, y: containerView.bounds.midY - blobRadius)
    }
    
    var secondPoint : CGPoint {
        return CGPoint(x: containerView.bounds.midX, y: containerView.bounds.midY - blobRadius)
    }
    
    var thirdPoint : CGPoint{
        let blobSpacing = containerView.frame.width/4
        return CGPoint(x: containerView.bounds.midX + blobSpacing, y: containerView.bounds.midY - blobRadius)
    }
    
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    public override init(onView view: UIView, withSize size: LoaderSize?) {
        super.init(onView: view, withSize: size)
        
        if let superView = parentView{
            configureContainerview(fromSuperView: superView)
            superView.addSubview(containerView)
           
            if !containerView.frame.isEmpty{
                configureBlobs()
                containerView.layer.addSublayer(firstBlob)
                containerView.layer.addSublayer(secondBlob)
                containerView.layer.addSublayer(thirdBlob)
            }
        }
    }
    func containerViewFrame(_ superView: UIView?)->CGRect{
        if let view = superView{
            let contanerWidth = view.frame.width/3 //one-third of parent width
            let contanerHeight = (contanerWidth/3)*2 // two-third of the width
            
            let widthOffset = (view.frame.width - contanerWidth)/2
            let heightOffset = (view.frame.height - contanerHeight)/2
            
            return view.bounds.insetBy(dx: widthOffset, dy: heightOffset)
        }
        return .zero
    }
    
    func configureContainerview(fromSuperView view:UIView){
        containerView.frame = containerViewFrame(view)
        containerView.layer.cornerRadius = 15.0
        containerView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.4)
        containerView.center = view.center
    }
   
    private func configureBlobs() {
        blobRadius = containerView.frame.width/12
        if let path = getPathForLayer(forFixedRadius: blobRadius){
            
            firstBlob.layerFillColor = blobColor
            firstBlob.layerStrokeColor = Defaults.clearColor
            firstBlob.layerLineWith = 0.0
            firstBlob.layerPath = path
            firstBlob.position = firstPoint
            firstBlob.add(animationGroup_one, forKey: "firstBlobAnimation")

            secondBlob.layerFillColor = blobColor
            secondBlob.layerStrokeColor = Defaults.clearColor
            secondBlob.layerLineWith = 0.0
            secondBlob.layerPath = path
            secondBlob.position = secondPoint
            secondBlob.add(animationGroup_two, forKey: "secondBlobAnimation")
            
            thirdBlob.layerFillColor = blobColor
            thirdBlob.layerStrokeColor = Defaults.clearColor
            thirdBlob.layerLineWith = 0.0
            thirdBlob.layerPath = path
            thirdBlob.position = thirdPoint
            thirdBlob.add(animationGroup_three, forKey: "thirdBlobAnimation")
        }
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if let view = parentView{
            containerView.center = view.center
        }
    }
    
    var firstKeyFrameValues : (CGPoint, CGPoint){
        
        let firstValue =  CGPoint(x: firstPoint.x, y: firstPoint.y)
        let secondValue = CGPoint(x: firstPoint.x, y: firstPoint.y + 25)
        
        return (firstValue, secondValue)
    }
    
    var secondKeyFrameValues : (CGPoint, CGPoint){
        
        let firstValue =  CGPoint(x: secondPoint.x, y: secondPoint.y)
        let secondValue = CGPoint(x: secondPoint.x, y: secondPoint.y + 25)
        
        return (firstValue, secondValue)
    }
    
    var thirdKeyFrameValues : (CGPoint, CGPoint){
        
        let firstValue =  CGPoint(x: thirdPoint.x, y: thirdPoint.y)
        let secondValue = CGPoint(x: thirdPoint.x, y: thirdPoint.y + 25)
        
        return (firstValue, secondValue)
    }
    
    var firstKeyFrameAnimation : CAKeyframeAnimation{
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "position")
        keyFrameAnimation.values = [firstKeyFrameValues.0,
                                    firstKeyFrameValues.1]
        
        keyFrameAnimation.keyTimes = [0, 0.25]
        keyFrameAnimation.duration = 0.50
        keyFrameAnimation.autoreverses = true
        return keyFrameAnimation
    }
    
    var secondKeyFrameAnimation : CAKeyframeAnimation{
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "position")
        keyFrameAnimation.values = [secondKeyFrameValues.0,
                                    secondKeyFrameValues.1
        ]
        keyFrameAnimation.keyTimes = [0.05, 0.30]
        keyFrameAnimation.duration = 0.55
        keyFrameAnimation.autoreverses = true
        return keyFrameAnimation
    }
    
    var thirdKeyFrameAnimation : CAKeyframeAnimation{
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "position")
        keyFrameAnimation.values = [thirdKeyFrameValues.0,
                                    thirdKeyFrameValues.1
        ]
        keyFrameAnimation.keyTimes = [0.10, 0.35]
        keyFrameAnimation.duration = 0.60
        keyFrameAnimation.autoreverses = true
        return keyFrameAnimation
    }
    
    var animationGroup_one: CAAnimationGroup{
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [firstKeyFrameAnimation]
        animationGroup.duration = 1.0
        animationGroup.repeatCount = .infinity
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationGroup.fillMode = .forwards
        animationGroup.isRemovedOnCompletion = false
        return animationGroup
    }
    var animationGroup_two: CAAnimationGroup{
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [secondKeyFrameAnimation]
        animationGroup.beginTime = CACurrentMediaTime() + 0.05
        animationGroup.duration = 1.0
        animationGroup.repeatCount = .infinity
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationGroup.fillMode = .forwards
        animationGroup.isRemovedOnCompletion = false
        return animationGroup
    }
    
    var animationGroup_three: CAAnimationGroup{
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [thirdKeyFrameAnimation]
        animationGroup.beginTime = CACurrentMediaTime() + 0.10
        animationGroup.duration = 1.0
        animationGroup.repeatCount = .infinity
        animationGroup.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animationGroup.fillMode = .forwards
        animationGroup.isRemovedOnCompletion = false
        return animationGroup
    }
    
    public override func hide() {
        super.hide()
        containerView.removeFromSuperview()
    }
    
}
