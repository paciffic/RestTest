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


    @IBOutlet weak var btnGet: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
  
    
  
    @IBAction func btnSend_Pushed(sender: AnyObject) {
        print("Push Button is pressed!!")
    }
    
    @IBAction func btnGet_Pushed(sender: AnyObject) {
        //tfMsg.text = "Button was pushed!!!"
        
//    var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888")!)
//            httpGet(request){
//                (data, error) -> Void in
//                if error != nil {
//                    println(error)
//                    self.tfMsg.text = error
//                } else {
//                    println(data)
//                    self.tfMsg.text = "success"
//                    self.tfContent.text = data
//                }
//        }
    
        process_json()
    }
    
    func process_json()
    {
        // URL 처리
        let urlAsString = "http://localhost:8888"
        let url = NSURL(string: urlAsString)!
        let urlSession = NSURLSession.sharedSession()
        
        // connection task 처리
        let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                println(error.localizedDescription)
            }
            var err: NSError?
            print(response)
            
            // JSON 데이터 parsing
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as! NSDictionary
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            print(jsonResult)
            
            // Dictionary에 담긴 데이터 변수로 할당
            let jsonUsername: String? = jsonResult["username"] as? String
            let jsonEmail: String? = jsonResult["email"] as? String
            let jsonFistName: String? = jsonResult["firstName"]as? String
            let jsonLastName: String? = jsonResult["lastName"] as? String
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tfUsername.text = jsonUsername
                self.tfEmail.text = jsonEmail
                self.tfFirstName.text = jsonFistName
                self.tfLastName.text = jsonLastName
                
            })
        })
        // web reques 시작
        jsonQuery.resume()    }
    
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

