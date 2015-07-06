//
//  AddRecordViewController.swift
//  iOS-Developer-Challenge
//
//  Created by Arslan Asim on 06/07/2015.
//  Copyright (c) 2015 Arslan Asim. All rights reserved.
//

import UIKit
import RealmSwift
protocol AddRecordViewControllerDelegate{
    func AddRecordVCRecordAdded()
}
class AddRecordViewController: UIViewController {

    @IBOutlet weak var txtFoodName: UITextField!
    @IBOutlet weak var txtServing: UITextField!
    
    
    @IBOutlet weak var totalFat: UITextField!
    @IBOutlet weak var protain: UITextField!
    @IBOutlet weak var cholesterol: UITextField!
    @IBOutlet weak var monosaturated: UITextField!
    @IBOutlet weak var sugar: UITextField!
    @IBOutlet weak var calories: UITextField!
    @IBOutlet weak var polyUnsaturated: UITextField!
    @IBOutlet weak var potassium: UITextField!
    @IBOutlet weak var sodium: UITextField!
    @IBOutlet weak var totalCarbs: UITextField!
    @IBOutlet weak var saturated: UITextField!
    @IBOutlet weak var diataryFibre: UITextField!
    
    var delegate : AddRecordViewControllerDelegate! = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnCancelTapped(sender: UIButton) {
        self .dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func btnAddRecordTapped(sender: UIButton) {
        if (self.txtFoodName.text.isEmpty || self.txtServing.text.isEmpty)
        {
            let alert = UIAlertView(title: "Please Review", message: "Food Name and Serving is Necessary", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
        }else
        {
            let realm = Realm()
            var newModel = FoodModel()
            newModel._id = self.randomStringWithLength(8) as String
            newModel.name = self.txtFoodName.text
            
            var importantPortions:PortionsModel = PortionsModel()
            
            importantPortions.name = self.txtServing.text
            importantPortions.important.dietary_fibre.value = (self.diataryFibre.text as NSString).doubleValue
            importantPortions.important.saturated.value = (self.saturated.text as NSString).doubleValue
            importantPortions.important.total_carbs.value = (self.totalCarbs.text as NSString).doubleValue
            importantPortions.important.sodium.value = (self.sodium.text as NSString).doubleValue
            importantPortions.important.potassium.value = (self.potassium.text as NSString).doubleValue
            importantPortions.important.polyunsaturated.value = (self.polyUnsaturated.text as NSString).doubleValue
            importantPortions.important.calories.value = (self.calories.text as NSString).doubleValue
            importantPortions.important.sugar.value = (self.sugar.text as NSString).doubleValue
            importantPortions.important.monounsaturated.value = (self.monosaturated.text as NSString).doubleValue
            importantPortions.important.cholesterol.value = (self.cholesterol.text as NSString).doubleValue
            importantPortions.important.protein.value = (self.protain.text as NSString).doubleValue
            importantPortions.important.total_fats.value = (self.totalFat.text as NSString).doubleValue
            newModel.portions.append(importantPortions)
            realm.write {
                realm.add(newModel, update: true)
            }
            self.delegate.AddRecordVCRecordAdded()

            self .dismissViewControllerAnimated(true, completion: nil)

            
        }

    }
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
