//
//  SequentialQuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 02/02/2022.
//

import Foundation



class SequentialQuestionStrategy: BaseQuestionStrategy {
    
    convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let questions = questionGroup.questions
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}
