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
    
    var gameSession: GameSession?
    private var onGameEnd: (() -> Void)?
    private var questionSequence: QuestionSequenceStrategy!
    
    func setQuestionSequence(_ sequence: QuestionSequenceStrategy){
        self.questionSequence = sequence
    }
    
    func startGame(onGameEnd: (() -> Void)? ){
        gameSession = GameSession(questionsCount: questionSequence.count())
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
            let question = questionSequence.get(gameSession.currentQuestionNum.value),
            !gameSession.finished
        else {
            return false
        }
        
        if (question.rightAnswer == answerNum){
            gameSession.currentQuestionNum.value = gameSession.currentQuestionNum.value + 1
        } else {
            finishGame()
            return false
        }
        if (gameSession.currentQuestionNum.value == gameSession.questionsCount){
            finishGame()
            return false
        }
        return true
    }
    
    func currentQuestion() -> String {
        guard
            let gameSession = gameSession,
            let question = questionSequence.get(gameSession.currentQuestionNum.value)
        else {
            return ""
        }
        return question.question
    }
    
    func currentAnswers(_ byNum: Int) -> String {
        guard
            let gameSession = gameSession,
            let question = questionSequence.get(gameSession.currentQuestionNum.value),
            byNum >= 0,
            byNum < question.answers.count
        else {
            return ""
        }
        return question.answers[byNum]
    }
}

protocol GameDelegate {
    func checkAnswerAndContinueGame(answerNum: Int) -> Bool
    func currentQuestion() -> String
    func currentAnswers(_ byNum: Int) -> String
}



    

