//
//  MAMultiLayeredLoader.swift
//  MACoolLoader
//
//  Created by Mahjabin Alam on 2020/07/28.
//  Copyright © 2020 Mahjabin Alam. All rights reserved.
//

import UIKit

public class MAMultiLayeredLoader: BaseUIView {
    
    private var outerLayer = MALoaderLayer(ofType: .hollow, path: nil)
    private var movingLayer = MALoaderLayer(ofType: .hollow, path: nil)
    private var innerLayer =  MALoaderLayer(ofType: .hollow, path: nil)
    
    let layerDifference: CGFloat = 20
   
    var totalKeyframeDuration : CFTimeInterval = 0.50
    var lastAnimationDuration : CFTimeInterval = 0.0
    let lastStrokeEndLength : CGFloat = 0.25
    
    let keyframeDuration = 0.5
    
    public var outerLayerColor: UIColor = UIColor.systemBlue{
        didSet{
            configureOuterLayer()
        }
    }
    public var movingLayerColor: UIColor = UIColor.white{
        didSet{
            configureMovingLayer()
        }
    }
    public var innerLayerColor: UIColor = UIColor.lighterShade(ofColor: UIColor.systemBlue, andPercentage: 30){
        didSet{
            configureInnerLayer()
        }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override init(onView view: UIView, withSize size: LoaderSize?) {
        super.init(onView: view, withSize: size)
        
        configureOuterLayer()
        self.layer.addSublayer(outerLayer)
        
        configureInnerLayer()
        self.layer.addSublayer(innerLayer)
        
        configureMovingLayer()
        self.layer.addSublayer(movingLayer)
    }
    
    func configureMovingLayer(){
        if let movingPath = segmentedLayerPath(){
            movingLayer.layerPath = movingPath
            movingLayer.lineWidth  = Defaults.strokeWidth
            movingLayer.layerFillColor = UIColor.clear
            movingLayer.layerStrokeColor = movingLayerColor
            movingLayer.add(moveBetweenLayersAnimation, forKey: nil)
        }
    }
    
    func configureOuterLayer(){
        if let outerPath = outerLayerPath(){
            outerLayer.layerPath = outerPath
            outerLayer.lineWidth  = Defaults.strokeWidth
            outerLayer.layerFillColor = UIColor.clear
            outerLayer.strokeColor = outerLayerColor.cgColor
        }
    }
    
    func configureInnerLayer(){
        if let innerPath = innerLayerPath(){
            innerLayer.layerPath = innerPath
            innerLayer.lineWidth  = Defaults.strokeWidth
            innerLayer.layerFillColor = UIColor.clear
            innerLayer.strokeColor = innerLayerColor.cgColor
        }
    }
    
    func outerLayerPath()->UIBezierPath?{
        let radius  = getAdjustableRadius(forSuperViewFrame: frame, withOffset: 0.0)
        let path = getPathForLayer(forFixedRadius: radius)
        return path
    }
    
    func innerLayerPath()->UIBezierPath?{
        let radius  = getAdjustableRadius(forSuperViewFrame: frame, withOffset: layerDifference)
        let path = getPathForLayer(forFixedRadius: radius)
        return path
    }
    
    func segmentedLayerPath()->UIBezierPath?{
        let path : UIBezierPath?
        let radius  = getAdjustableRadius(forSuperViewFrame: frame, withOffset: layerDifference/2)
        path = UIBezierPath(arcCenter: .zero , radius: radius, startAngle: -CGFloat.pi/2, endAngle: -CGFloat.pi/4, clockwise: true)
        return path
    }
    
    var moveBetweenLayersAnimation: CAKeyframeAnimation{
        let animation = CAKeyframeAnimation(keyPath:"transform.rotation")
        animation.values = [0, 1, 2, 3, 4, 5, 6]
        animation.keyTimes = [0, 0.5, 1.0, 1.5, 2.0, 2.5]
        animation.duration = 3.0
        animation.calculationMode = .cubicPaced
        animation.repeatCount = .infinity
        animation.isAdditive = true
        return animation
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if let view = parentView{
            outerLayer.position = view.center
            movingLayer.position = view.center
            innerLayer.position = view.center
        }
    }
}
