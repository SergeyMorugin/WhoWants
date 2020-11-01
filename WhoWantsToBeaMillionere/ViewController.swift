//
//  ViewController.swift
//  WhoWantsToBeaMillionere
//
//  Created by Matthew on 28.10.2020.
//  Copyright © 2020 Ostagram Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let questions: [Question] = [
        Question(question: "A magnet would most likely attract which of the following?", answers: [
            "Metal", "Plastic", "Wood", "The wrong man"
        ], rightAnswer: 0),
        Question(question: "Where did Scotch whisky originate?", answers: [
            "Ireland", "Wales", "The United States", "Scotland"
        ], rightAnswer: 3),
        Question(question: "In fancy hotels, it is traditional for what tantalizing treat to be left on your pillow?", answers: [
            "A pretzel", "An apple", "A mint", "A photo of Wolf Blitzer"
        ], rightAnswer: 2),
        Question(question: "In the United States, what is traditionally the proper way to address a judge?", answers: [
            "Your holiness", "Your honor", "Your eminence", "You da man!"
        ], rightAnswer: 1),
        Question(question: "The popular children's song 'It's Raining, It's Pouring' mentions an 'old man' doing what?", answers: [
            "Snoring", "Cooking", "Laughing", "Yelling at squirrels"
        ], rightAnswer: 0),
        Question(question: "If someone asked to see your ID, what might you show them?", answers: [
            "Your tongue", "Your teeth", "Your passport", "The door"
        ], rightAnswer: 2),
        Question(question: "Where did Scotch whisky originate?", answers: [
            "Ireland", "Wales", "The United States", "Scotland"
        ], rightAnswer: 3),
        Question(question: "Where did Scotch whisky originate?", answers: [
            "Ireland", "Wales", "The United States", "Scotland"
        ], rightAnswer: 3),
        Question(question: "Where did Scotch whisky originate?", answers: [
            "Ireland", "Wales", "The United States", "Scotland"
        ], rightAnswer: 3)
    ]

    @IBOutlet weak var lastGameResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //lastGameResultLabel.text = "\(RecordsCaretaker.shared.records.count)"
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
        Game.shared.setQuestionSequence(LineQuestionsSequence(qustions: questions))
    }
    
    @IBAction func randomSequenceUnwindAction(unwindSegue: UIStoryboardSegue){
        Game.shared.setQuestionSequence(RandomQuestionsSequence(qustions: questions))
    }


}

