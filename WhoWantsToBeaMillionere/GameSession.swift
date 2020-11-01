//
//  GameSession.swift
//  WhoWantsToBeaMillionere
//
//  Created by Matthew on 29.10.2020.
//  Copyright © 2020 Ostagram Inc. All rights reserved.
//

import Foundation

class GameSession {
    var questionsCount: Int
    var currentQuestionNum: Observable<Int>
    var finished: Bool = false
    
    init (questionsCount: Int){
        self.questionsCount = questionsCount
        self.currentQuestionNum = Observable(0)
    }
    
    deinit {
        currentQuestionNum.removeObservers()
    }
    
}

struct Record: Codable{
    let date: Date
    let value: Int
}

final class RecordsCaretaker {
    
    static let shared = RecordsCaretaker()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "records"
    private var _records: [Record]
    
    var records: [Record] {
        return _records
    }
    
    func append(_ record: Record) {
        _records.append(record)
        save(records: _records)
    }
    
    private func save(records: [Record]) {
        do {
            let data = try self.encoder.encode(records)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    private init(){
        guard let data = UserDefaults.standard.data(forKey: key) else {
            self._records = []
            return
        }
        do {
            self._records = try self.decoder.decode([Record].self, from: data)
        } catch {
            print(error)
            self._records = []
        }
        
    }
}
