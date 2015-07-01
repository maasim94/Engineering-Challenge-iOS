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
class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var tableViewFoodNames: UITableView!
    var json: JSON = JSON.nullJSON

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableViewFoodNames .reloadData()
               // Do any additional setup after loading the view, typically from a nib.
    }
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.json.type {
        case Type.Array, Type.Dictionary:
            return self.json.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JSONCell", forIndexPath: indexPath) as! UITableViewCell
        
        var row = indexPath.row
        var subJson : JSON = self.json[row];
        switch self.json.type {
        case .Array:
            cell.textLabel?.text = subJson["name"].string
            cell.detailTextLabel?.text = self.json.arrayValue.description
        case .Dictionary:
            let key: AnyObject = (self.json.object as! NSDictionary).allKeys[row]
            let value = self.json[key as! String]
            cell.textLabel?.text = "\(key)"
            cell.detailTextLabel?.text = value.description
        default:
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = self.json.description
        }
        
        return cell
    }
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        var object: AnyObject
        switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
        case .OrderedSame, .OrderedDescending:
            object = segue.destinationViewController.topViewController
        case .OrderedAscending:
            object = segue.destinationViewController
        }
        
        if let nextController = object as? ViewController {
            
            if let indexPath = self.tableViewFoodNames.indexPathForSelectedRow() {
                var row = indexPath.row
                var nextJson: JSON = JSON.nullJSON
                
                switch self.json.type {
                case .Array:
                    nextJson = self.json[row]
                case .Dictionary where row < self.json.dictionaryValue.count:
                    let key = self.json.dictionaryValue.keys.array[row]
                    if let value = self.json.dictionary?[key] {
                        nextJson = value
                    }
                default:
                    print("")
                }
                nextController.json = nextJson
                print(nextJson)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

