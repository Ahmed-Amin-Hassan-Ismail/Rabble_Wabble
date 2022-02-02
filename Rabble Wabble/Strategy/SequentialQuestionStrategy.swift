//
//  SequentialQuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 02/02/2022.
//

import Foundation



class SequentialQuestionStrategy: QuestionStrategy {
    
    private let questionGroup: QuestionGroup
    private var questionIndex: Int = 0
    
    init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
    }
    
    
    var title: String {
        return questionGroup.title
    }
    
    var correctCount: Int = 0
     
    var incorrectCount: Int = 0
    
    func advanceToNextQuestion() -> Bool {
        guard questionIndex + 1 < questionGroup.questions.count else { return false }
        questionIndex += 1
        return true
    }
    
    func currentQuestion() -> Question {
        return questionGroup.questions[questionIndex]
    }
    
    func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }
    
    func markQuestionIncorrect(_ question: Question) {
        incorrectCount += 1
    }
    
    func questionIndexTitle() -> String {
        return "\(questionIndex + 1)/" + "\(questionGroup.questions.count)"
    }
    
    
}
