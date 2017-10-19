//
//  ViewController.swift
//  SmartTutor
//
//  Created by Tapas Mandal on 2017-10-18.
//  Copyright © 2017 htsmartlabs. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MainMenuVC: UIViewController {

    @IBOutlet weak var bottomAdView: GADBannerView!
    @IBOutlet weak var topAdView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        topAdView.adUnitID = "ca-app-pub-7438198586349335/3637278446"
        bottomAdView.adUnitID = "ca-app-pub-7438198586349335/3637278446"
        
        topAdView.rootViewController = self
        bottomAdView.rootViewController = self
        
        topAdView.load(request)
        bottomAdView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

