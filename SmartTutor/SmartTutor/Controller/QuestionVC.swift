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

    @IBOutlet weak var btnAns4: BorderButton!
    @IBOutlet weak var btnAns3: BorderButton!
    @IBOutlet weak var btnAns2: BorderButton!
    @IBOutlet weak var btnAns1: BorderButton!
    
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblRight: UILabel!
    @IBOutlet weak var lblWrong: UILabel!
    
    @IBOutlet weak var lblQuestion: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var bottomAdVew: GADBannerView!
    
    var mathOperation: MathOperation!
    
    //Declaring variables to count score
    static var total = 0
    static var right = 0
    static var wrong = 0
    var answer: [Int] = [ 0 , 0 , 0 , 0 ]
    var question = "Q. What is "
    var choice = 0
    
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

        clearStaticVariables()
        questionGenerator()
        displayUI()
    }
    
    @IBAction func onAnswerSelected(_ sender: BorderButton) {
        checkAnswer(selectedButton: sender)
    }
    
    @IBAction func btnRestart(_ sender: Any) {
        clearStaticVariables()
        cleanUI()
        questionGenerator()
        displayUI()
    }
    @IBAction func btnNext(_ sender: Any) {
        cleanUI()
        questionGenerator()
        displayUI()
    }
    @IBAction func btnFinish(_ sender: Any) {
        if(QuestionVC.total > 0){
            let alertController = UIAlertController(title: "\(mathOperation.menuSelection) Quiz", message:
                "Your score is \( ( QuestionVC.right * 100 ) / QuestionVC.total )%", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController(title: "\(mathOperation.menuSelection) Quiz", message:
                "You did not take a test ", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        clearStaticVariables()
        cleanUI()
        questionGenerator()
        displayUI()
    }

    //the function is used to clean the user interface afer the student answer one question
    func cleanUI(){
        question = "Q. What is "
        for i in 0..<answer.count {
            answer[i] = 0
        }
        choice = 0
        btnAns1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btnAns2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btnAns3.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btnAns4.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
    //It generates random questions and answers for the quiz
    func questionGenerator(){
        
        if(mathOperation.menuSelection == "Addition"){
            let num1 = Int( arc4random_uniform( 100 ) )
            let num2 = Int( arc4random_uniform( 100 ) )
            choice = Int( arc4random_uniform( 4 ) )
            
            answer[choice] = num1 + num2
            
            for i in 0..<answer.count {
                if( answer[i] == 0){
                    answer[i] = Int( arc4random_uniform( 150 ) )
                }
            }
            
            question = "\(question) \(num1) + \(num2)"
            
        }else if(mathOperation.menuSelection == "Subtraction"){
            choice = Int( arc4random_uniform( 4 ) )
            
            while (true) {
                let num1 = Int( arc4random_uniform( 100 ) )
                let num2 = Int( arc4random_uniform( 100 ) )
                if(num1 >= num2){
                    question = "\(question) \(num1) - \(num2)"
                    answer[choice] = num1 - num2
                    break;
                }
            }
            for i in 0..<answer.count {
                if( answer[i] == 0){
                    answer[i] = Int( arc4random_uniform( 70 ) )
                }
            }
        }else if(mathOperation.menuSelection == "Multiplication"){
            let num1 = Int( arc4random_uniform( 20 )+1 )
            let num2 = Int( arc4random_uniform( 10 )+1 )
            choice = Int( arc4random_uniform( 4 ) )
            
            answer[choice] = num1 * num2
            
            for i in 0..<answer.count {
                if( answer[i] == 0){
                    answer[i] = Int( arc4random_uniform( 200 ) )
                }
            }
            
            question = "\(question) \(num1) X \(num2)"

        }else if(mathOperation.menuSelection == "Division"){
            choice = Int( arc4random_uniform( 4 ) )
            
            while(true){
                let num1 = Int( arc4random_uniform( 200 ) + 1 )
                let num2 = Int( arc4random_uniform( 10 ) + 1 )
                if(num1 % num2 == 0){
                    question = "\(question) \(num1) / \(num2)"
                    answer[choice] = num1 / num2
                    break;
                }
            }
            
            for i in 0..<answer.count {
                if( answer[i] == 0){
                    answer[i] = Int( arc4random_uniform( 20 ) )
                }
            }
        }
    }
    
    //It display the question and answer and score in the user interface
    func displayUI(){
        lblQuestion.text = question
        
        btnAns1.setTitle(String(answer[0]), for: .normal)
        btnAns2.setTitle(String(answer[1]), for: .normal)
        btnAns3.setTitle(String(answer[2]), for: .normal)
        btnAns4.setTitle(String(answer[3]), for: .normal)
        
        btnAns1.isEnabled = true
        btnAns2.isEnabled = true
        btnAns3.isEnabled = true
        btnAns4.isEnabled = true

    }
    
    //after you select the answer the function checks the answer for right or wrong
    func checkAnswer(selectedButton: BorderButton){

        btnAns1.isEnabled = false
        btnAns2.isEnabled = false
        btnAns3.isEnabled = false
        btnAns4.isEnabled = false

        if(btnAns1.tag == choice){
            btnAns1.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }else if(btnAns2.tag == choice){
            btnAns2.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }else if(btnAns3.tag == choice){
            btnAns3.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }else if(btnAns4.tag == choice){
            btnAns4.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }
        
        let response = Int(selectedButton.title(for: .normal)!)
        
        QuestionVC.total += 1
        
        if response == answer[choice] {
            QuestionVC.right += 1
            selectedButton.backgroundColor=#colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }else {
            QuestionVC.wrong += 1
            selectedButton.backgroundColor=#colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
        
        lblTotal.text = String(QuestionVC.total)
        lblRight.text = String(QuestionVC.right)
        lblWrong.text = String(QuestionVC.wrong)
    }
    func clearStaticVariables(){
        QuestionVC.total = 0
        QuestionVC.right = 0
        QuestionVC.wrong = 0
        
        lblTotal.text = String(QuestionVC.total)
        lblRight.text = String(QuestionVC.right)
        lblWrong.text = String(QuestionVC.wrong)
    }
}
