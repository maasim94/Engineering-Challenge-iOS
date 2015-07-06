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
import SVProgressHUD

class InitialViewController: UIViewController , SearchViewControllerDelegate , AddRecordViewControllerDelegate ,UITableViewDelegate , UITableViewDataSource  {

    var foodDataSaved:Results<FoodModel>?
    let realm = Realm()

    @IBOutlet weak var foodDataTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
           // Do any additional setup after loading the view.
        self.foodDataSaved = self.realm.objects(FoodModel)

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if(self.foodDataTableView != nil){
            return self.foodDataSaved!.count
        }
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.foodDataTableView != nil){
            let data : FoodModel = self.foodDataSaved![section]
            return data.portions.count
        }
        
        return 0;
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let data : FoodModel = self.foodDataSaved![section]
        return data.name;

    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DataCell", forIndexPath: indexPath) as! DataTableViewCell
        
        var row = indexPath.row
        var section = indexPath.section
        let data : FoodModel = self.foodDataSaved![section]
        let portions = data.portions[row]
        cell.lblServingName.text = portions.name;
        
        cell.lblDiaFiberUnit.text = portions.important.dietary_fibre.unit
        cell.lblPolyUnit.text = portions.important.polyunsaturated.unit
        cell.lblPotassiumUnit.text = portions.important.potassium.unit
        cell.lblSaturatedUnit.text = portions.important.saturated.unit
        cell.lblSodiumUnit.text = portions.important.sodium.unit
        cell.lblTotalCarbsUnit.text = portions.important.total_carbs.unit
        
        
        cell.lblDiaFiberValue.text = NSString(format: "%f",portions.important.dietary_fibre.value) as String
        cell.lblPolyValue.text = NSString(format: "%f",portions.important.polyunsaturated.value) as String
        cell.lblPotassiumValue.text = NSString(format: "%f",portions.important.potassium.value) as String
        cell.lblSaturatedValue.text = NSString(format: "%f",portions.important.saturated.value) as String
        cell.lblSodiumValue.text = NSString(format: "%f",portions.important.sodium.value) as String
        cell.lblTotalCarbsValue.text = NSString(format: "%f",portions.important.total_carbs.value) as String

        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       
        
    }
    // MARK: - NetwrokCall
    func getFoodDetailsOfFood(foodName:String)
    {
        SVProgressHUD.show()
        Alamofire.request(.GET, "http://test.holmusk.com/food/search", parameters: ["q" : foodName]).responseJSON(options: NSJSONReadingOptions()) { (req, res, jsonValue, error) -> Void in
            if(error != nil) {
                SVProgressHUD.dismiss()
                NSLog("Error: \(error)")
                println(req)
                println(res)
            }
            else {
                SVProgressHUD.dismiss()
                var json : JSON = JSON(jsonValue!)
                self.parseDataAndSave(json)
            }
        }
    }
    // MARK: - ParseData
    func parseDataAndSave(json:JSON)
    {
        
        var allData : NSMutableArray =  NSMutableArray()
        for (index: String, subJson: JSON) in json {
            
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
            self.realm.write {
                self.realm.add(foodModel, update: true)
            }
            
        }
        
        self.foodDataSaved = self.realm.objects(FoodModel)
        self.foodDataTableView.reloadData()
        
    }

    // MARK: - IB-Actions

    @IBAction func btnSearchTapped(sender: UIButton) {
        self.performSegueWithIdentifier("toSearch", sender: self)
    }
    
    @IBAction func btnAddRecordTapped(sender: UIButton) {
        self.performSegueWithIdentifier("toAddRecord", sender: self)

    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
          // Get the new view controller using segue.destinationViewController.
        if (segue.identifier == "toSearch")
        {
            let nextController = segue.destinationViewController as! SearchViewController
            nextController.delegate = self
        }else
        {
            let nextController = segue.destinationViewController as! AddRecordViewController
            nextController.delegate = self
        }
     
    }
    // MARK: - Search Delegate

    func SearchVCdidSearchComplete(selectedFood: String) {
        self.getFoodDetailsOfFood(selectedFood)
    }
    // MARK: - Add record Delegate
    func AddRecordVCRecordAdded() {
        self.foodDataSaved = self.realm.objects(FoodModel)
        self.foodDataTableView.reloadData()
        

    }
    // MARK: - Style bar

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
