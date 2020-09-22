//
//  MARadiatingBlobLoader.swift
//  MACoolLoader
//
//  Created by Mahjabin Alam on 2020/09/22.
//  Copyright © 2020 Mahjabin Alam. All rights reserved.
//

import UIKit

public class MARadiatingBlobLoader: BaseUIView{

    public var blobColor = UIColor.systemRed{
        didSet{
            configureBlobs()
        }
    }
    public var blobBorderColor = UIColor.lighterShade(ofColor: UIColor.systemRed, andPercentage: -30){
        didSet{
           configureBlobs()
        }
    }
   
    var containerView : UIView = UIView(frame:.zero)
     
    var firstBlob = MALoaderLayer(ofType: .solid, path: nil)
    var secondBlob = MALoaderLayer(ofType: .solid, path: nil)
    var thirdBlob = MALoaderLayer(ofType: .solid, path: nil)
    
    var blobRadius: CGFloat = 0.0
    
    var firstPoint : CGPoint {
        let blobSpacing = containerView.frame.width/4
        return CGPoint(x: containerView.bounds.midX - blobSpacing, y: containerView.bounds.midY)
    }
    
    var secondPoint : CGPoint {
        return CGPoint(x: containerView.bounds.midX, y: containerView.bounds.midY)
    }
    
    var thirdPoint : CGPoint{
        let blobSpacing = containerView.frame.width/4
        return CGPoint(x: containerView.bounds.midX + blobSpacing, y: containerView.bounds.midY)
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
            firstBlob.layerStrokeColor = blobBorderColor
            firstBlob.layerLineWith = 0.0
            firstBlob.layerPath = path
            firstBlob.position = firstPoint
            firstBlob.add(animateLineWidth, forKey: "firstBlobAnimation")

            secondBlob.layerFillColor = blobColor
            secondBlob.layerStrokeColor = blobBorderColor
            secondBlob.layerLineWith = 0.0
            secondBlob.layerPath = path
            secondBlob.position = secondPoint
            secondBlob.add(animateLineWidth, forKey: "secondBlobAnimation")
            
            thirdBlob.layerFillColor = blobColor
            thirdBlob.layerStrokeColor = blobBorderColor
            thirdBlob.layerLineWith = 0.0
            thirdBlob.layerPath = path
            thirdBlob.position = thirdPoint
            thirdBlob.add(animateLineWidth, forKey: "thirdBlobAnimation")
            
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if let view = parentView{
            containerView.center = view.center
        }
    }
 
    var animateLineWidth: CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "lineWidth")
        animation.toValue = blobRadius
        animation.fromValue = 1.0
        animation.duration = 1.0
        animation.repeatCount = .greatestFiniteMagnitude
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.autoreverses = true
        return animation
    }
    
    public override func hide() {
        super.hide()
        containerView.removeFromSuperview()
    }
}
