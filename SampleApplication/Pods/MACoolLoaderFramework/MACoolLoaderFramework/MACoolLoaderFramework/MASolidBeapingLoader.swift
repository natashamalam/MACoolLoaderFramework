//
//  MASolidBeapingLoader.swift
//  MACoolLoader
//
//  Created by Mahjabin Alam on 2020/07/28.
//  Copyright © 2020 Mahjabin Alam. All rights reserved.
//

import UIKit


public class MASolidBeapingLoader: BaseUIView {
  
    let solidLoader = MALoaderLayer(ofType: .solid, path: nil)
    
    public var loaderLineWidth: CGFloat = 10.0{
        didSet{
            configureLayer()
        }
    }
    public var loaderBorderColor: UIColor = Defaults.strokeColor{
        didSet{
            configureLayer()
        }
    }
    public var loaderBackgroundColor : UIColor = UIColor.darkerShade(ofColor: Defaults.strokeColor, andPercentage: 30){
        didSet{
            configureLayer()
        }
    }
    
    public required init?(coder: NSCoder) {
       super.init(coder: coder)
    }
    
    public override init(onView view: UIView, withSize size: LoaderSize?) {
        super.init(onView: view, withSize: size)
       
        if let path = getPathForLayer(){
            solidLoader.setPath(path)
            configureLayer()
            self.layer.addSublayer(solidLoader)
        }
    }

    func configureLayer() {
        solidLoader.layerLineWith = loaderLineWidth
        solidLoader.layerStrokeColor = loaderBorderColor
        solidLoader.layerFillColor = loaderBackgroundColor
        solidLoader.add(fillAnimation, forKey: nil)
    }
    
    public override func layoutSubviews() {
       super.layoutSubviews()
        if let view = parentView{
            solidLoader.position = view.center
        }
    }

    var fillAnimation : CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.0
        animation.toValue = 0.2
        animation.duration = 1.5
        animation.repeatCount = .greatestFiniteMagnitude
        animation.autoreverses = true
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        return animation
    }
  
    
}
