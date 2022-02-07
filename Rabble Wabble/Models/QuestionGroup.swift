//
//  QuestionGroup.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 01/02/2022.
//

import Foundation



//MARK: - Originator
//MARK: -
class QuestionGroup: Codable {
    
    class Score: Codable {
        var correctCount: Int = 0
        var incorrectCount: Int = 0
        
        init() { }
    }
    
    let questions: [Question]
    var score: Score
    let title: String
    
    
    init(questions: [Question], score: Score = Score(), title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
}
