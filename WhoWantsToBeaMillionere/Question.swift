//
//  Question.swift
//  WhoWantsToBeaMillionere
//
//  Created by Matthew on 28.10.2020.
//  Copyright © 2020 Ostagram Inc. All rights reserved.
//

import Foundation

struct Question: Codable{
    let question: String
    let answers: [String]
    let rightAnswer: Int
}


fileprivate let questions: [Question] = [
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


final class QuestionCaretaker {
    
    static let shared = QuestionCaretaker()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "questions"
    private var _records: [Question]
    
    var records: [Question] {
        return _records
    }
    
    func append(_ record: Question) {
        _records.append(record)
        save(records: _records)
    }
    
    private func save(records: [Question]) {
        do {
            let data = try self.encoder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    private init(){
        guard let data = UserDefaults.standard.data(forKey: key) else {
            self._records = questions
            return
        }
        do {
            self._records = try self.decoder.decode([Question].self, from: data)
            
        } catch {
            print(error)
            self._records = []
        }
        
        if (self._records.count == 0){
            self._records = questions
        }
        
    }
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


