//
//  ViewController.swift
//  Whats the Weather
//
//  Created by Marco F.A. Corzani on 06.01.15.
//  Copyright (c) 2015 Alphaweb. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    
    @IBOutlet weak var cityTextField: UITextField!
    
    
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func buttonPressed(sender: AnyObject) {
        
    self.view.endEditing(true)   // Fährt das Keyboard runter bei Abschuss
    
    var urlString = "http://www.weather-forecast.com/locations/" + cityTextField.text.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest"
    
        var url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
           
            var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding)
            
        if urlContent!.containsString("<span class=\"phrase\">") {
            
            var contentArray = urlContent!.componentsSeparatedByString("<span class=\"phrase\">")    // Backslash vor doppeltem Anführungszeichen
            
            var newContentArray = contentArray[1].componentsSeparatedByString("</span>")
            
//            println(contentArray[1]) //Also der Teil nach "<span class=\"phrase\">"
//            
//            println(newContentArray[0]) //Also der Teil nach "<span class=\"phrase\">" und vor  </span>
            
            dispatch_async(dispatch_get_main_queue()) {   // warum auch immer, so gehts ruckzuck, vorher 30 Sekunden
                // update label
            self.message.text = newContentArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º") as String
            }
            
        } else {
            dispatch_async(dispatch_get_main_queue()) {   // warum auch immer, so gehts ruckzuck, vorher 30 Sekunden
            self.message.text = "City could not be found!"
                }
            }
            
            }
       
        task.resume()
    
        
    }
}

