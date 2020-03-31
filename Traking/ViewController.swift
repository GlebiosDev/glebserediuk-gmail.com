//
//  ViewController.swift
//  Traking
//
//  Created by MacBookPro on 3/31/20.
//  Copyright © 2020 MacBookPro. All rights reserved.
//

import UIKit
import TSLocationManager

class ViewController: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get a reference to the SDK
        let bgGeo = TSLocationManager.sharedInstance()
        let config = TSConfig.sharedInstance()
        
        
        bgGeo?.viewController = self
        
        config?.update({builder in
            
            builder?.debug = true
            builder?.logLevel = tsLogLevelVerbose
            builder?.desiredAccuracy = kCLLocationAccuracyBest
            builder?.distanceFilter = 10
            builder?.stopOnTerminate = false
            builder?.startOnBoot = true
//            builder?.url = "http://your.server.com/locations"
        })
        
        bgGeo?.onLocation({location in
            if let to = location?.toDictionary(){
                print("[location] \(to)")
            }
        }, failure:{ error in
            print("[location] error \(NSNumber(value: (error as NSError?)?.code ?? 0))")
            })
        
        bgGeo?.ready()
        
        if config?.enabled != false{
            //start
            bgGeo?.start()
        }

    }
    
}




