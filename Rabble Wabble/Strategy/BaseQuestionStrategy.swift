//
//  BaseQuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 05/02/2022.
//

import Foundation


class BaseQuestionStrategy: QuestionStrategy {
    
    private let questions: [Question]
    private var questionIndex: Int = 0
    private var questionGroupCaretaker: QuestionGroupCaretaker
    private var questionGroup: QuestionGroup {
        return questionGroupCaretaker.selectedQuestionGroup
    }
    
    init(questionGroupCaretaker: QuestionGroupCaretaker,
         questions: [Question]) {
        self.questionGroupCaretaker = questionGroupCaretaker
        self.questions = questions
        self.questionGroupCaretaker.selectedQuestionGroup.score.reset()
    }
    
    
    var title: String {
        return questionGroup.title
    }
    
    var correctCount: Int {
        get {
            return questionGroup.score.correctCount
        } set {
            questionGroup.score.correctCount = newValue
        }
    }
    
    var incorrectCount: Int {
        get {
            return questionGroup.score.incorrectCount
        } set {
            questionGroup.score.incorrectCount = newValue
        }
    }
    
    func advanceToNextQuestion() -> Bool {
        try? questionGroupCaretaker.save()
        guard questionIndex + 1 < questions.count else { return false }
        questionIndex += 1
        return true
    }
    
    func currentQuestion() -> Question {
        return questions[questionIndex]
    }
    
    func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }
    
    func markQuestionIncorrect(_ question: Question) {
        incorrectCount += 1
    }
    
    func questionIndexTitle() -> String {
        return "\(questionIndex + 1)/\(questions.count)"
    }
    
    
}
