//
//  ViewController.swift
//  WhoWantsToBeaMillionere
//
//  Created by Matthew on 28.10.2020.
//  Copyright © 2020 Ostagram Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    

    @IBOutlet weak var lastGameResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //lastGameResultLabel.text = "\(RecordsCaretaker.shared.records.count)"
        let questions = QuestionCaretaker.shared.records
        Game.shared.setQuestionSequence(RandomQuestionsSequence(qustions: questions))
        
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "startGame":
            guard let destination = segue.destination as? GameViewController else { return }
            Game.shared.startGame { [weak self] in
                self?.lastGameResultLabel.text = "Previus result is \(Game.shared.gameSession!.currentQuestionNum.value)/\(Game.shared.gameSession!.questionsCount)"
                let percent = Int(Game.shared.gameSession!.currentQuestionNum.value*100/Game.shared.gameSession!.questionsCount)
                RecordsCaretaker.shared.append(Record(date: Date(), value: percent))
            }
            destination.delegate = Game.shared
        default:
            break
        }
    }
    
    @IBAction func lineSequenceUnwindAction(unwindSegue: UIStoryboardSegue){
        let questions = QuestionCaretaker.shared.records
        Game.shared.setQuestionSequence(LineQuestionsSequence(qustions: questions))
    }
    
    @IBAction func randomSequenceUnwindAction(unwindSegue: UIStoryboardSegue){
        let questions = QuestionCaretaker.shared.records
        Game.shared.setQuestionSequence(RandomQuestionsSequence(qustions: questions))
    }


}

