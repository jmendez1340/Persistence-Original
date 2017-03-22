//
//  ViewController.swift
//  Persistence
//
//  Created by Jason Mendez on 3/15/17.
//  Copyright © 2017 Jason Mendez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lineFields: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fileURL = self.dataFileURL()
        if (FileManager.default.fileExists(atPath: fileURL.path!)) {
            if let array = NSArray(contentsOf: fileURL as URL) as? [String] {
                for i in 0..<array.count {
                    lineFields[i].text = array[i]
                }
            }
        }
        
        
        let app = UIApplication.shared // deleting the () gets rid of the cannor call value of non-function type
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: Notification.Name.UIApplicationWillResignActive, object: app)
        
    }

    
    func applicationWillResignActive(notification: NSNotification) {
        let fileURL = self.dataFileURL()
        let array = (self.lineFields as NSArray).value(forKey: "text") as! NSArray
        array.write(to: fileURL as URL, atomically: true)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dataFileURL() -> NSURL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url:NSURL?
        url = URL(fileURLWithPath: "") as NSURL?  // Create a blank path
        do {
            try url = urls.first!.appendingPathComponent("data.plist") as NSURL?
                // somehow doesn't work. page 432
        } catch {
            print("Error is \(error)")
        }
        return url!
    }


}

