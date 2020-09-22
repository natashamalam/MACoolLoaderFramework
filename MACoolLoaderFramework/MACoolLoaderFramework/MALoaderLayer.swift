//
//  MALoaderLayer.swift
//  MACoolLoader
//
//  Created by Mahjabin Alam on 2020/09/21.
//  Copyright © 2020 Mahjabin Alam. All rights reserved.
//

import UIKit

public class MALoaderLayer: CAShapeLayer {
    
    public var layerStrokeColor: UIColor = Defaults.strokeColor{
        didSet{
            configureLayer()
        }
    }
    public var layerFillColor: UIColor = Defaults.fillColor{
        didSet{
            configureLayer()
        }
    }
    
    public var layerLineWith : CGFloat = 5.0{
        didSet{
            configureLayer()
        }
    }
    public var layerLineCap : CAShapeLayerLineCap = .round{
        didSet{
            configureLayer()
        }
    }
    public var layerPath : UIBezierPath?{
        didSet{
            if let path = layerPath{
                setPath(path)
            }
        }
    }

    public var type: LoaderLayerType = .hollow{
        didSet{
            configureLayer()
        }
    }
    
    
    public override init() {
        super.init()
        configureLayer()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayer()
    }
    
    public init(ofType type: LoaderLayerType?, path: UIBezierPath?){
        super.init()
        if let layerType = type{
            self.type = layerType
        }
        if let loaderPath = path{
            setPath(loaderPath)
        }
        configureLayer()
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    func configureLayer(){
        self.strokeColor = layerStrokeColor.cgColor
        if type == .hollow{
            self.fillColor = Defaults.clearColor.cgColor
        }
        else{
            self.fillColor = layerFillColor.cgColor
        }
        
        self.lineWidth = layerLineWith
        self.lineCap = layerLineCap
    }
    
    func setPath(_ path:UIBezierPath){
        self.path = path.cgPath
    }
    
    
}
