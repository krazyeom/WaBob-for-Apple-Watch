//
//  GlanceController.swift
//  Wabob WatchKit Extension
//
//  Created by Steve Yeom on 5/12/15.
//  Copyright (c) 2015 2nd Jobs. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
  
  @IBOutlet weak var table: WKInterfaceTable!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
    // Configure interface objects here.
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
    let url = NSURL(string: "https://wabob.herokuapp.com")
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
      var jsonError: NSError?
      
      let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError)
      
      if let array = jsonObject as? NSArray {
        if array.count > 0 {
          self.table.setNumberOfRows(array.count, withRowType: "MenuRowType")
          
          for (index, menu) in enumerate(array) {
            if let b1menus = menu as? NSDictionary {
              var f = b1menus["f"] as! String
              var n = b1menus["n"] as! String
              var c = b1menus["c"] as! String
              var w = b1menus["w"] as! String
              var i = b1menus["i"] as! String
              
              let controller = self.table.rowControllerAtIndex(index) as! MenuRowController
              controller.menutitle.setText(n)
              controller.price.setText(w)
              
              //FixMe
              controller.menuTitleString = n
              controller.priceString = w
              controller.floor = f
              controller.calorie = c
              controller.imgurl = i
            }
          }
        }
      }
    }
    task.resume()
    }
    
    override func didDeactivate() {
      // This method is called when watch view controller is no longer visible
      super.didDeactivate()
    }
    
}
