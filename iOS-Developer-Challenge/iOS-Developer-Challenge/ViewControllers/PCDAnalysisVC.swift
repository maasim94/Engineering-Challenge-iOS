//
//  PCDAnalysisVC.swift
//  coExec
//
//  Created by Taimoor Ali on 5/7/15.
//  Copyright (c) 2015 Taimoor Ali. All rights reserved.
//

import UIKit

class PCDAnalysisVC: UIViewController, UISearchBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var pcdSearchBar: UISearchBar!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var menuViewHeightConstraint: NSLayoutConstraint!
    var menuOpen : Bool = false
    var selectedPickerRowNumber : Int = 0
    var filterDataForKPIPeriod : String = ""
    var kpiPeriodsArray: NSMutableArray = NSMutableArray()
    var pcdAnalysisArray: NSMutableArray = NSMutableArray()
    var searchDeliveriesArray: NSMutableArray = NSMutableArray()
    @IBOutlet var pcdTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        pcdSearchBar.returnKeyType = .Done
        pcdSearchBar.enablesReturnKeyAutomatically = false
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Meeting Promises"
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.title = ""
        super.viewWillDisappear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Custom methods
    
    
    @IBAction func KPIPeriodButtonPressed (sender: AnyObject) {
        self.view.endEditing(true)
        if(menuOpen == false){
            menuOpen = true
            UIView.animateWithDuration(Double(0.5), animations: {
                self.menuViewHeightConstraint.constant = 190.0
                self.view.layoutIfNeeded()
            })
        }else{
            menuOpen = false
            UIView.animateWithDuration(Double(0.5), animations: {
                self.menuViewHeightConstraint.constant = 0.0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func stateNameButtonPressed(sender: UIButton){
//        cell.stateButton.addTarget(self, action: "stateNameButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
//        cell.stateButton.tag = indexPath.row
//        
//        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//        var detailPCDAnalysisVC: DetailPCDAnalysisVC = DetailPCDAnalysisVC(nibName: "DetailPCDAnalysisVC", bundle: nil)
//        detailPCDAnalysisVC.stateData = self.searchDeliveriesArray.objectAtIndex(sender.tag) as NSDictionary
//        appDelegate.navController?.pushViewController(detailPCDAnalysisVC, animated: true)
    }
    
    
    // MARK: - Table view data source
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDeliveriesArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var  cell:PCDTableViewCell! = tableView.dequeueReusableCellWithIdentifier("PCDCellID") as? PCDTableViewCell
        
        if (cell == nil) {
            let nib:Array = NSBundle.mainBundle().loadNibNamed("PCDTableViewCell", owner: self, options: nil)
            cell = nib[0] as? PCDTableViewCell
        }
        
        let dict : NSDictionary = self.searchDeliveriesArray.objectAtIndex(indexPath.row) as! NSDictionary
       
        
        cell.sOrignalPCDMetLbl.textColor = getTextColorForValue(cell.sOrignalPCDMetLbl.text!)
        cell.sRevisedPCDMetLbl.textColor = getTextColorForValue(cell.sRevisedPCDMetLbl.text!)
        cell.sPCDEstablishedLbl.textColor = getTextColorForValue(cell.sPCDEstablishedLbl.text!)
        cell.sPCDCommunicatedbl.textColor = getTextColorForValue(cell.sPCDCommunicatedbl.text!)
        cell.sRevisedPCDCommunicatedLbl.textColor = getTextColorForValue(cell.sRevisedPCDCommunicatedLbl.text!)
        
        cell.PCDView.layer.cornerRadius = 5.0
        cell.PCDView.layer.borderWidth = 2.0
        cell.PCDView.layer.borderColor = UIColor(red: 221.0/255.0, green: 221.0/255.0, blue: 221.0/255.0, alpha: 1.0).CGColor
        
        cell.backgroundColor = UIColor.clearColor()
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.view.endEditing(true)
    }
    
    func getTextColorForValue(value : NSString) -> UIColor
    {
        let newString:String = value.stringByReplacingOccurrencesOfString("%", withString: "")
        let fieldValue:Double = (newString as NSString).doubleValue
        if (fieldValue < 0) {
            let color2 = UIColor.redColor()
            return color2
        }else{
            let color2 = UIColor(red: 0.0/255.0, green: 174.0/255.0, blue: 8.0/255.0, alpha: 1.0)
            return color2
        }
    }
    // MARK: - Search Bar Delegate Functions
    
    func searchBarSearchButtonClicked( searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        if count(searchBar.text)<1{
            self.searchDeliveriesArray = self.pcdAnalysisArray
            self.pcdTableView.reloadData()
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if count(searchText)>0{
            var tempArray: NSMutableArray = []
            for index in 0...self.pcdAnalysisArray.count-1{
                let match1: NSRange = self.myFunc(self.pcdAnalysisArray.objectAtIndex(index).objectForKey("operatingUnit")?.objectForKey("operatingUnitName") as! NSString, searchText: searchText)
                if match1.location != NSNotFound{
                    tempArray.addObject(self.pcdAnalysisArray.objectAtIndex(index))
                }
            }
            searchDeliveriesArray = tempArray.mutableCopy() as! NSMutableArray
            
        }else{
            searchDeliveriesArray = self.pcdAnalysisArray as NSMutableArray
        }
        self.pcdTableView.reloadData()
    }
    
    func myFunc(arrayString: NSString, searchText: NSString) -> NSRange{
        var range = arrayString.rangeOfString(searchText as String, options: .CaseInsensitiveSearch)
        return range
    }
    
    // Mark: - UIPicker View Delegate Functions
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35.0
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.kpiPeriodsArray.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.kpiPeriodsArray.objectAtIndex(row).objectForKey("periodName") as! NSString as String
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData:String = self.kpiPeriodsArray.objectAtIndex(row).objectForKey("periodName") as! NSString as String
        var myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Light", size: 13.0)!,NSForegroundColorAttributeName:UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)])
        return myTitle
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPickerRowNumber = row
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool{
            return true
    }
    
    @IBAction func tapDetected(sender: UITapGestureRecognizer) {
        // Send PCS Analysis call Here
        pcdSearchBar.text = ""
        
        menuOpen = false
        UIView.animateWithDuration(Double(0.5), animations: {
            self.menuViewHeightConstraint.constant = 0.0
            self.view.layoutIfNeeded()
        })
    }
    
}
