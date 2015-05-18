//
//  DetailInterfaceController.swift
//  Wabob
//
//  Created by Steve Yeom on 5/13/15.
//  Copyright (c) 2015 2nd Jobs. All rights reserved.
//

import Foundation
import WatchKit

class DetailInterfaceController: WKInterfaceController {
  
  @IBOutlet weak var img: WKInterfaceImage!
  @IBOutlet weak var menuTitle: WKInterfaceLabel!
  @IBOutlet weak var floor: WKInterfaceLabel!
  @IBOutlet weak var calorie: WKInterfaceLabel!
  @IBOutlet weak var price: WKInterfaceLabel!
  
  var menu: NSDictionary!
  var imgurl: String!
  
  override func awakeWithContext(context: AnyObject?) {
    super.awakeWithContext(context)
    if let detailMenu = context as? Dictionary<String, String> {
        menu = detailMenu
    }

  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
    if menu != nil {
      var url = NSURL(string: menu.objectForKey("image") as! String)!
      var request1: NSURLRequest = NSURLRequest(URL: url)
      let queue:NSOperationQueue = NSOperationQueue()
      NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
        if let imgData = data {
          self.img.setImage(UIImage(data: imgData))
        }
      })
      
      self.menuTitle.setText(menu.objectForKey("menuTitle") as? String)
      self.floor.setText(menu.objectForKey("floor") as? String)
      self.calorie.setText((menu.objectForKey("calorie") as? String)! + " kcal")
      self.price.setText(menu.objectForKey("price") as? String)
    } else {
      self.menuTitle.setText("closed now")
    }
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
}