//
//  Question.swift
//  WhoWantsToBeaMillionere
//
//  Created by Matthew on 28.10.2020.
//  Copyright © 2020 Ostagram Inc. All rights reserved.
//

import Foundation

struct Question{
    let question: String
    let answers: [String]
    let rightAnswer: Int
}

protocol QuestionSequenceStrategy {
    func get(_ byNum: Int) -> Question?
    func count() -> Int
    init(qustions: [Question])
    
}

class LineQuestionsSequence: QuestionSequenceStrategy{
    private var questions: [Question]
    
    func get(_ byNum: Int) -> Question? {
        return questions[byNum]
    }
    
    required init(qustions: [Question]) {
        self.questions = qustions
    }
    
    func count() -> Int {
        return questions.count
    }
}

class RandomQuestionsSequence: QuestionSequenceStrategy{
    private var questions: [Question]
    private var randomSequence:[Int]
    
    func get(_ byNum: Int) -> Question? {
        return questions[randomSequence[byNum]]
    }
    
    required init(qustions: [Question]) {
        self.questions = qustions
        self.randomSequence = Array(0..<questions.count).shuffled()
    }
    
    func count() -> Int {
        return questions.count
    }
}
