//
//  ViewController.swift
//  SampleApplication
//
//  Created by Mahjabin Alam on 2020/09/23.
//

import UIKit
import MACoolLoaderFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loader = MARadiatingBlobLoader(onView: self.view, withSize: .large)
        loader.show()
    }


}

