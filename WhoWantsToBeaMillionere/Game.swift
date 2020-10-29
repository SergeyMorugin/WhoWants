//
//  Game.swift
//  WhoWantsToBeaMillionere
//
//  Created by Matthew on 29.10.2020.
//  Copyright © 2020 Ostagram Inc. All rights reserved.
//

import Foundation

class Game: GameDelegate {
    
    static var shared = Game()
    private init() {
        
    }
    
    private let questions: [Question]? = [
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
    
    var gameSession: GameSession?
    var onGameEnd: (() -> Void)?
    
    
    func startGame(onGameEnd: (() -> Void)? ){
        gameSession = GameSession(questionsCount: questions!.count)
        self.onGameEnd = onGameEnd
    }
    
    func finishGame(){
        guard
            let gameSession = gameSession,
            !gameSession.finished
        else {
            return
        }
        gameSession.finished = true
        onGameEnd?()
        self.gameSession = nil
    }
    
    func checkAnswerAndContinueGame(answerNum: Int) -> Bool{
        guard
            let gameSession = gameSession,
            let questions = questions,
            !gameSession.finished
        else {
            return false
        }
        if (questions[gameSession.currentQuestionNum].rightAnswer == answerNum){
            gameSession.currentQuestionNum = gameSession.currentQuestionNum + 1
        } else {
            finishGame()
            return false
        }
        if (gameSession.currentQuestionNum == gameSession.questionsCount){
            finishGame()
            return false
        }
        return true
    }
    
    func currentQuestion() -> String {
        guard
            let gameSession = gameSession,
            let questions = questions
        else {
            return ""
        }
        return questions[gameSession.currentQuestionNum].question
    }
    
    func currentAnswers(_ byNum: Int) -> String {
        guard
            let gameSession = gameSession,
            let questions = questions,
            byNum >= 0,
            byNum < questions[gameSession.currentQuestionNum].answers.count
        else {
            return ""
        }
        return questions[gameSession.currentQuestionNum].answers[byNum]
    }
}

protocol GameDelegate {
    func checkAnswerAndContinueGame(answerNum: Int) -> Bool
    func currentQuestion() -> String
    func currentAnswers(_ byNum: Int) -> String
}



    

