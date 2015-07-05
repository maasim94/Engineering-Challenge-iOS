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
    @IBOutlet weak var searchBar: UISearchBar!
    var searchResults:Results<SearchPridiction>?
    let realm = Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.searchResults = Results<SearchPridiction>?()
        //self.tableViewFoodNames .reloadData()
               // Do any additional setup after loading the view, typically from a nib.
    }
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.searchResults != nil){
            return self.searchResults!.count
        }
        
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JSONCell", forIndexPath: indexPath) as! UITableViewCell
        
        var row = indexPath.row
        let food : SearchPridiction = self.searchResults![row];
        cell.textLabel?.text = food.nameOfFoodToSearch
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    // MARK: - Search Bar Delegate Functions
    
    func searchBarSearchButtonClicked( searchBar: UISearchBar)
    {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
       
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if count(searchText)>0
        {
            self.searchResults  = self.realm.objects(SearchPridiction).filter("nameOfFoodToSearch CONTAINS[c] %@",searchText)
            self.tableViewFoodNames.reloadData()
        }else
        {

        }
        
       
        
        
    }
    // MARK: - IB-Actions
    @IBAction func btnCancelTapped(sender: UIButton) {
        self.searchBar.resignFirstResponder()
        
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

