//
//  Constants.swift
//  MACoolLoader
//
//  Created by Mahjabin Alam on 2020/09/22.
//  Copyright © 2020 Mahjabin Alam. All rights reserved.
//

import UIKit

struct Defaults{
    static let strokeColor = UIColor.systemBlue
    static let clearColor = UIColor.clear
    static let strokeWidth : CGFloat = 5.0
    static let fillColor = UIColor.darkerShade(ofColor: UIColor.systemBlue, andPercentage: 30)
    static let pulsatingColor = UIColor(red: 155/255, green: 204/255, blue: 252/255, alpha: 1.0)
}

public enum LoaderSize{
    case small
    case medium
    case large
}

public enum LoaderLayerType{
    case hollow
    case solid
}
