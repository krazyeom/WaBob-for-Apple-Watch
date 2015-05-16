//
//  MenuRowController.swift
//  Wabob
//
//  Created by Steve Yeom on 5/13/15.
//  Copyright (c) 2015 2nd Jobs. All rights reserved.
//

import Foundation
import WatchKit

class MenuRowController: NSObject {
  @IBOutlet weak var menutitle: WKInterfaceLabel!
  @IBOutlet weak var price: WKInterfaceLabel!
  @IBOutlet weak var img: WKInterfaceImage!
  var priceString: String!
  var menuTitleString: String!
  var floor: String!
  var calorie: String!
  var imgurl: String!
}
