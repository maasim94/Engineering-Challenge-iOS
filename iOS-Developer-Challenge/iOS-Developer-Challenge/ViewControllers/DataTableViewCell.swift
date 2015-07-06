//
//  PCDTableViewCell.swift
//  coExec
//
//  Created by Taimoor Ali on 5/8/15.
//  Copyright (c) 2015 Taimoor Ali. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet var lblServingName: UILabel!
  
    @IBOutlet var ViewContainer: UIView!
    
    @IBOutlet weak var lblDiaFiberValue: UILabel!
    @IBOutlet weak var lblDiaFiberUnit: UILabel!
    @IBOutlet weak var lblSaturatedValue: UILabel!
    @IBOutlet weak var lblSaturatedUnit: UILabel!
    
    @IBOutlet weak var lblTotalCarbsValue: UILabel!
    @IBOutlet weak var lblTotalCarbsUnit: UILabel!
    @IBOutlet weak var lblSodiumValue: UILabel!
    @IBOutlet weak var lblSodiumUnit: UILabel!
    @IBOutlet weak var lblPotassiumValue: UILabel!
    @IBOutlet weak var lblPotassiumUnit: UILabel!
    @IBOutlet weak var lblPolyValue: UILabel!
    @IBOutlet weak var lblPolyUnit: UILabel!

    @IBOutlet weak var btnReadMore: UIButton!
    
    

}

