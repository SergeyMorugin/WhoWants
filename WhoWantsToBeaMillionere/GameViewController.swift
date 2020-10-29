//
//  GameViewController.swift
//  WhoWantsToBeaMillionere
//
//  Created by Matthew on 29.10.2020.
//  Copyright © 2020 Ostagram Inc. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var delegate: GameDelegate!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1Btn: UIButton!
    @IBOutlet weak var answer2Btn: UIButton!
    @IBOutlet weak var answer3Btn: UIButton!
    @IBOutlet weak var answer4Btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         updatePage()
        // Do any additional setup after loading the view.
    }
    
    func updatePage(){
        questionLabel.text = delegate.currentQuestion()
        answer1Btn.setTitle(delegate.currentAnswers(0), for: .normal)
        answer2Btn.setTitle(delegate.currentAnswers(1), for: .normal)
        answer3Btn.setTitle(delegate.currentAnswers(2), for: .normal)
        answer4Btn.setTitle(delegate.currentAnswers(3), for: .normal)
    }

    @IBAction func onAnswerClick(_ sender: UIButton) {
        guard
            let strId = sender.restorationIdentifier,
            let id = Int(strId)
        else { return }
        
        
        if (delegate.checkAnswerAndContinueGame(answerNum: id)){
            updatePage()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}
