//
//  QuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 02/02/2022.
//

import Foundation


protocol QuestionStrategy: AnyObject {
    
    var title: String { get }
    
    var correctCount: Int { get }
    var incorrectCount: Int { get }
    
    func advanceToNextQuestion() -> Bool
    
    func currentQuestion() -> Question
    
    func markQuestionCorrect(_ question: Question)
    func markQuestionIncorrect(_ question: Question)
    
    func questionIndexTitle() -> String
}
