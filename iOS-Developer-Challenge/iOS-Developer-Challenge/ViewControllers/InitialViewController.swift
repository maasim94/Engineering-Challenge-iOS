//
//  InitialViewController.swift
//  iOS-Developer-Challenge
//
//  Created by M.Arslan Asim on 02/07/2015.
//  Copyright (c) 2015 Arslan Asim. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InitialViewController: UIViewController {

    var json: JSON = JSON.nullJSON

    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "http://test.holmusk.com/food/search", parameters: ["q" : "cucumber"]).responseJSON(options: NSJSONReadingOptions()) { (req, res, jsonValue, error) -> Void in
            if(error != nil) {
                NSLog("Error: \(error)")
                println(req)
                println(res)
            }
            else {
                 self.json = JSON(jsonValue!)
                self.performSegueWithIdentifier("present", sender: self)

                //                for (index: String, subJson: JSON) in self.json {
                //                    //Do something you want
                //                   // println(subJson)
                //                    if let name = subJson["name"].string
                //                    {
                //                        println(name)
                //                    }
                //                }
            }
        }

//
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextController = segue.destinationViewController.topViewController as! ViewController
        nextController.json = self.json;
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
