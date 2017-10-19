//
//  QuestionVC.swift
//  SmartTutor
//
//  Created by Tapas Mandal on 2017-10-18.
//  Copyright © 2017 htsmartlabs. All rights reserved.
//

import UIKit
import GoogleMobileAds

class QuestionVC: UIViewController {

    
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblRight: UILabel!
    @IBOutlet weak var lblWrong: UILabel!
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var bottomAdVew: GADBannerView!
    
    var mathOperation: MathOperation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(mathOperation.menuSelection)
        // Do any additional setup after loading the view.

        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        bottomAdVew.adUnitID = "ca-app-pub-7438198586349335/3637278446"
        
        bottomAdVew.rootViewController = self
        bottomAdVew.load(request)
        
        lblTitle.text = "\(mathOperation.menuSelection) Quiz"
    }
    
    @IBAction func onAnswerSelected(_ sender: BorderButton) {
    }
    @IBAction func btnRestart(_ sender: Any) {
    }
    
    @IBAction func btnNext(_ sender: Any) {
    }
    @IBAction func btnFinish(_ sender: Any) {
    }
    @IBAction func btnExit(_ sender: Any) {
    }

}
