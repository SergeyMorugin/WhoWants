//
//  AddQuestionViewController.swift
//  WhoWantsToBeaMillionere
//
//  Created by Matthew on 01.11.2020.
//  Copyright © 2020 Ostagram Inc. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController{


    
    @IBOutlet weak var questionField: UITextView!
    @IBOutlet weak var Answer1Field: UITextField!
    @IBOutlet weak var Answer2Field: UITextField!
    @IBOutlet weak var Answer3Field: UITextField!
    @IBOutlet weak var Answer4Field: UITextField!
    @IBOutlet weak var correctAnswerSelector: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        questionField.layer.borderWidth = 1.0
        questionField.layer.cornerRadius = 8
    }
    
    @IBAction func onAddQuestion(_ sender: Any) {
        if (validateQuestion()){
            let question = Question(
                question: questionField.text!,
                answers: [
                    Answer1Field.text!,
                    Answer2Field.text!,
                    Answer3Field.text!,
                    Answer4Field.text!
                ],
                rightAnswer: correctAnswerSelector.selectedSegmentIndex)
            print(question)
            QuestionCaretaker.shared.append(question)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func validateQuestion() -> Bool{
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
