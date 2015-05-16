//
//  InterfaceController.swift
//  Wabob WatchKit Extension
//
//  Created by Steve Yeom on 5/12/15.
//  Copyright (c) 2015 2nd Jobs. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
  
  @IBOutlet weak var table: WKInterfaceTable!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
    // Configure interface objects here.
    NSLog("test")
    let url = NSURL(string: "http://pebob.herokuapp.com")
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
        } else {
          self.table.setNumberOfRows(1, withRowType: "MenuRowType")
          let controller = self.table.rowControllerAtIndex(0) as! MenuRowController
          controller.menutitle.setText("closed now")
          controller.price.setText("")
        }
      }
    }
    task.resume()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
//  override func performSegueWithIdentifier(
  
  override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int)
    -> AnyObject? {
    if segueIdentifier == "detailSegue" {
      let controller = table.rowControllerAtIndex(rowIndex) as! MenuRowController
      if (table.numberOfRows > 1) {
        return ["image":controller.imgurl, "menuTitle":controller.menuTitleString, "floor":controller.floor, "calorie":controller.calorie, "price":controller.priceString]
      }
      return nil  
    }
    return nil
  }

  
}
