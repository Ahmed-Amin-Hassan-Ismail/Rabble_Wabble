//
//  RandomQuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 02/02/2022.
//

import GameplayKit.GKRandomSource

class RandomQuestionStrategy: BaseQuestionStrategy {
    
    convenience init(questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCaretaker.selectedQuestionGroup!
        let randomSource = GKARC4RandomSource.sharedRandom()
        let questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
        self.init(questionGroupCaretaker: questionGroupCaretaker, questions: questions)
    }
}


