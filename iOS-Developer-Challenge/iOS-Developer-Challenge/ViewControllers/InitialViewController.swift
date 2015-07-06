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
import RealmSwift
class InitialViewController: UIViewController {

    var json: JSON = JSON.nullJSON

    override func viewDidLoad() {
        super.viewDidLoad()
//        
        let realm = Realm()

        let data  = realm.objects(FoodModel)
        
//        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
//            Int64(1 * Double(NSEC_PER_SEC)))
//        dispatch_after(delayTime, dispatch_get_main_queue()) {
//            self.performSegueWithIdentifier("present", sender: self)
//        }

        Alamofire.request(.GET, "http://test.holmusk.com/food/search", parameters: ["q" : "cucumber"]).responseJSON(options: NSJSONReadingOptions()) { (req, res, jsonValue, error) -> Void in
            if(error != nil) {
                NSLog("Error: \(error)")
                println(req)
                println(res)
            }
            else {
                 self.json = JSON(jsonValue!)
               // self.performSegueWithIdentifier("present", sender: self)
                var allData : NSMutableArray =  NSMutableArray()
                var realmArray: List = List()
                for (index: String, subJson: JSON) in self.json {
                    var foodModel : FoodModel = FoodModel()

                    let name : String = subJson["name"].string!
                    let _id : String = subJson["_id"].string!
                    
                   
                    foodModel._id = _id
                    foodModel.name = name
                    
                    let portions : JSON = subJson["portions"]
                    
                    for (index:String,portion:JSON ) in portions
                    {
                        var portionModel : PortionsModel  = PortionsModel()
                        let nutrientName = portion["name"].string
                        portionModel.name = nutrientName!
                        let importants :JSON = portion["nutrients"]["important"];
                        
                        var imp = ImportantModel();
                        
                        for (key: String, important: JSON) in importants
                        {
                            
                            
                            if (important==nil)
                            {
                            }else
                            {
                                var details : NutrientsDetailsModel  = NutrientsDetailsModel ()
                                details.unit = important["unit"].string!
                                details.value = important["value"].double!
                                imp.setValue(details, forKey: key)
                            }
                        }
                        portionModel.important = imp
                        foodModel.portions.append(portionModel)


                    }
                    allData.addObject(foodModel)
                    realm.write {
                        realm.add(foodModel, update: true)
                    }
//                    println(foodModel)

                }
                self.performSegueWithIdentifier("present", sender: self)
              //  println(realm.objects(FoodModel))
                // You only need to do this once (per thread)
            
                // Add to the Realm inside a transaction
                
            }
        }


        
        
//        
//        Alamofire.request(.GET, "http://test.holmusk.com/food/search", parameters: ["q" : "cucumber"]).response { (_, _, anyData, error) -> Void in
//            
//            let arrayData : NSData = anyData as! NSData
//            let dataArray: AnyObject?  = NSJSONSerialization.JSONObjectWithData(arrayData, options: NSJSONReadingOptions(), error: NSErrorPointer())
//            self.json = JSON(dataArray!)
//            println(self.json)
//
////            for (dicti) in dataArray as! NSArray
////            {
////                let model : ZBTemp = ZBTemp(dictionary: dicti as! [NSObject : AnyObject], error: nil)
////                
////                println(model)
////            }
//        }
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
     //   let nextController = segue.destinationViewController.topViewController as! ViewController
      //  nextController.json = self.json;
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
