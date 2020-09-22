//
//  UIViewExtension.swift
//  MACoolLoader
//
//  Created by Mahjabin Alam on 2020/08/06.
//  Copyright © 2020 Mahjabin Alam. All rights reserved.
//

import UIKit

public class BaseUIView: UIView{
    
    public weak var parentView: UIView?
    public var size: LoaderSize?
    
    var parenViewCenter: CGPoint?{
        if let frame = parentView?.bounds{
            return CGPoint(x: frame.midX, y: frame.midY)
        }
        return nil
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public init(onView view: UIView, withSize size: LoaderSize?) {
        super.init(frame: view.frame)
        self.size = size
        parentView = view
        self.autoresizingMask = .flexibleWidth
    }
    
    public func hide(){
        self.removeFromSuperview()
    }
    
    public func show(){
        if let view = parentView{
            view.addSubview(self)
        }
    }
    
    public func getAdjustableRadius(forSuperViewFrame frame: CGRect, withMultiplier multiplier: CGFloat = 1.0, withOffset offset: CGFloat = 0.0)->CGFloat{
        var devider: CGFloat = 8.0
        
        switch size{
            case .large:
                devider = 6.0
            case .medium:
                devider = 8.0
            case .small:
                devider = 10.0
            case .none:
                devider = 8.0
        }
        
        if offset > 0.0{
            if frame.width <= frame.height{
                return max((frame.width/devider - offset), 5.0)
            }
            else{
                return max((frame.height/devider - offset), 5.0)
            }
        }
        else{
            if frame.width <= frame.height{
                return max((frame.width/devider * multiplier), 5.0)
            }
            else{
                return max((frame.height/devider * multiplier), 5.0)
            }
        }
        
    }
    
    
    func getAdjustableLineWidth(forFrame rect: CGRect?)->CGFloat{
        if let frame = rect {
            if frame.width <= frame.height{
                return max(frame.width/30, 5.0)
            }
            else{
                return max(frame.height/30, 5.0)
            }
        }
        else{
            return Defaults.strokeWidth
        }
    }
    
    public func getPathForLayer(withMultiplier multiplier: CGFloat = 1.0, forFixedRadius radius: CGFloat = 0.0)->UIBezierPath?{
        var path : UIBezierPath?
        if radius > 0.0{
            path = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        }
        else if let frame = parentView?.frame{
            let adjustableRadius = getAdjustableRadius(forSuperViewFrame: frame, withMultiplier: multiplier)
            path = UIBezierPath(arcCenter: .zero , radius: adjustableRadius, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        }
        return path
    }
    
    
    
}
