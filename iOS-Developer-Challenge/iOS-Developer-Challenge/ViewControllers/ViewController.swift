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
import RealmSwift

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableViewFoodNames: UITableView!
    var tasks:Results<FoodModel>?
    override func viewDidLoad() {
        super.viewDidLoad()
       let realm = Realm()
        
        self.tasks = realm.objects(FoodModel)
        
        
        //self.tableViewFoodNames .reloadData()
               // Do any additional setup after loading the view, typically from a nib.
    }
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JSONCell", forIndexPath: indexPath) as! UITableViewCell
        
        var row = indexPath.row
        let food : FoodModel = self.tasks![row];
        cell.textLabel?.text = food.name
        cell.detailTextLabel?.text = food.portions.first?.name

        
        return cell
    }
    // MARK: - Navigation
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        
//        var object: AnyObject
//        switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
//        case .OrderedSame, .OrderedDescending:
//            object = segue.destinationViewController.topViewController
//        case .OrderedAscending:
//            object = segue.destinationViewController
//        }
//        
//        if let nextController = object as? ViewController {
//            
//            if let indexPath = self.tableViewFoodNames.indexPathForSelectedRow() {
//                var row = indexPath.row
//                var nextJson: JSON = JSON.nullJSON
//                
//                switch self.json.type {
//                case .Array:
//                    nextJson = self.json[row]
//                case .Dictionary where row < self.json.dictionaryValue.count:
//                    let key = self.json.dictionaryValue.keys.array[row]
//                    if let value = self.json.dictionary?[key] {
//                        nextJson = value
//                    }
//                default:
//                    print("")
//                }
//                nextController.json = nextJson
//                print(nextJson)
//            }
//        }
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

