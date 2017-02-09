//
//  ViewController.swift
//  quarter-back
//
//  Created by Cheung, Michael (GE Digital) on 2/5/17.
//  Copyright © 2017 Cheung, Michael (GE Digital). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet var passButton: UIButton!
    @IBOutlet var textToPass: UITextField!
    
    func openAppURL(urlScheme: String) {
        if let url = URL(string: urlScheme) {
            if UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: {
                        (success) in
                        print("Open \(urlScheme): \(success)")
                    })
                } else {
                    let success = UIApplication.shared.openURL(url)
                    print("Open \(urlScheme): \(success)")
                }
            } else {
                let alertController = UIAlertController(title: "Invalid Request", message:
                    "URL invalid, app must be downloaded to be opened", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func passText(_ sender: Any) {
        print("passing text to wide-receiver");
        if textToPass.text == "" {
            let alertController = UIAlertController(title: "Invalid Pass", message:
                "Please enter a text to be passed to the wide-receiver", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            return;

        }
        let urlPass: String = "catchText://" + self.textToPass.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        openAppURL(urlScheme: urlPass);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


