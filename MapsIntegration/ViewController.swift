//
//  ViewController.swift
//  MapsIntegration
//
//  Created by Vera on 12/6/17.
//  Copyright © 2017 Vera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imgVC: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = "perls"
        
        // Get the String.UTF8View.
        let bytes = name.utf8
        print(bytes)
        
        let value = "abc"
        
        for u in value.utf8 {
            // This value is a UInt16.
            print(u)
        }
        let string = "The string"
        let binaryData: Data? = string.data(using: .utf8, allowLossyConversion: false)
        print(binaryData!)
       self.imgVC.image = UIImage(named: "VENKATESHA")
        let imageData:Data = UIImagePNGRepresentation(self.imgVC.image!)!
        print(imageData)
        let base64 = imageData.base64EncodedString()
        print(base64)
       // let str = GTMBase64.stringByEncodingData:imageData
        
        UserDefaults.standard.set(imageData, forKey: "savedImage")
        self.imageView2.image = UIImage(data: UserDefaults.standard.object(forKey: "savedImage") as! Data)
        print(UIImage(data: UserDefaults.standard.object(forKey: "savedImage") as! Data) ?? "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

