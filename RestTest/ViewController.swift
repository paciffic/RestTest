//
//  ViewController.swift
//  RestTest
//
//  Created by paciffic on 2015. 6. 18..
//  Copyright (c) 2015년 paciffic. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var tfMsg: UITextField!
    @IBOutlet weak var tfContent: UITextField!
    
    @IBAction func btnSend_Pushed(sender: AnyObject) {
        //tfMsg.text = "Button was pushed!!!"
        
    var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888")!)
            httpGet(request){
                (data, error) -> Void in
                if error != nil {
                    println(error)
                    self.tfMsg.text = error
                } else {
                    println(data)
                    self.tfMsg.text = "success"
                    self.tfContent.text = data
                }
        }
    
    }
    
    func httpGet(request: NSURLRequest!, callback: (String, String?) -> Void) {
            var session = NSURLSession.sharedSession()
            var task = session.dataTaskWithRequest(request){
                (data, response, error) -> Void in
                if error != nil {
                    callback("", error.localizedDescription)
                } else {
                    var result = NSString(data: data, encoding:
                        NSASCIIStringEncoding)!
                    callback(result as String, nil)
                }
            }
            task.resume()
    }


}

