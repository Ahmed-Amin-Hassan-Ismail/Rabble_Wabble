//
//  RandomQuestionStrategy.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 02/02/2022.
//

import GameplayKit.GKRandomSource

class RandomQuestionStrategy: QuestionStrategy {
    
    private let questionGroup: QuestionGroup
    private var questionIndex = 0
    private var questions: [Question]
    
    init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
        
        
        let randomSource = GKARC4RandomSource.sharedRandom()
        self.questions =
        randomSource.arrayByShufflingObjects(
            in: questionGroup.questions) as! [Question]
    }
    
    var title: String {
        return questionGroup.title
    }
    
    var correctCount: Int = 0
    
    var incorrectCount: Int = 0
    
    func advanceToNextQuestion() -> Bool {
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
        return "\(questionIndex + 1)/" + "\(questions.count)"
    }
    
    
}
