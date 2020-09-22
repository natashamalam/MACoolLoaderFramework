//
//  ViewController.swift
//  SampleApplication
//
//  Created by Mahjabin Alam on 2020/09/21.
//

import UIKit
import MACoolLoaderFramework

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loader = MARadiatingBlobLoader(onView: imageView, withSize: .medium)
        loader.show()
    }


}

