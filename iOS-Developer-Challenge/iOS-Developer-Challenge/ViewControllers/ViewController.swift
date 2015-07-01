//
//  ViewController.swift
//  iOS-Developer-Challenge
//
//  Created by Arslan Asim on 01/07/2015.
//  Copyright (c) 2015 Arslan Asim. All rights reserved.
//
import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        Alamofire.request(.GET, "http://test.holmusk.com/food/search", parameters: ["q" : "cucumber"]).responseJSON(options: NSJSONReadingOptions()) { (req, res, json, error) -> Void in
            if(error != nil) {
                NSLog("Error: \(error)")
                println(req)
                println(res)
            }
            else {
                var json = JSON(json!)
                println(json)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

