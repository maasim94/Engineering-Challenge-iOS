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

protocol SearchViewControllerDelegate{
    func SearchVCdidSearchComplete(selectedFood:String)
}
class SearchViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    
    @IBOutlet weak var tableViewFoodNames: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchResults:Results<SearchPridiction>?
    let realm = Realm()
    var delegate : SearchViewControllerDelegate! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.

        self.searchResults = Results<SearchPridiction>?()
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var row = indexPath.row
        let food : SearchPridiction = self.searchResults![row];
        self.delegate.SearchVCdidSearchComplete(food.nameOfFoodToSearch)
        self .dismissViewControllerAnimated(true, completion: nil)

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
       
            self.searchResults  = self.realm.objects(SearchPridiction).filter("nameOfFoodToSearch CONTAINS[c] %@",searchText)
            self.tableViewFoodNames.reloadData()
       
        
        
    }
    // MARK: - IB-Actions
    @IBAction func btnCancelTapped(sender: UIButton) {
        
        self .dismissViewControllerAnimated(true, completion: nil)

        
    }
    
    // MARK: - Style bar

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

