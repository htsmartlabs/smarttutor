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

    @IBOutlet weak var topAdView: GADBannerView!
    @IBOutlet weak var bottomAdView: GADBannerView!
    
    @IBOutlet weak var btnAdd: BorderButton!
    @IBOutlet weak var btnSub: BorderButton!
    @IBOutlet weak var btnMul: BorderButton!
    @IBOutlet weak var btnDiv: BorderButton!
    
    var mathOperation: MathOperation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mathOperation = MathOperation()
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        
        bottomAdView.adUnitID = "ca-app-pub-7438198586349335/3637278446"
        topAdView.adUnitID = "ca-app-pub-7438198586349335/3637278446"

        bottomAdView.rootViewController = self
        topAdView.rootViewController = self
        
        bottomAdView.load(request)
        topAdView.load(request)
    }

    @IBAction func onBtnPressed(_ sender: BorderButton) {
        if (sender.tag == 0){
            seletedButtonId(idType: "Addition")
        }else if(sender.tag == 1){
            seletedButtonId(idType: "Subtraction")
        }else if(sender.tag == 2){
            seletedButtonId(idType: "Multiplication")
        }else if(sender.tag == 3){
            seletedButtonId(idType: "Division")
        }
        performSegue(withIdentifier: "questionVCSegue", sender: self)
    }
    
    func seletedButtonId(idType: String){
        mathOperation.menuSelection = idType
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionVC = segue.destination as? QuestionVC {
            questionVC.mathOperation = mathOperation
        }
    }
    
    @IBAction func unwindFromQuestionVC(unwindSegue: UIStoryboardSegue){
    }
}

