//
//  QuestionGroupBuilder.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 10/02/2022.


import Foundation

class QuestionBuilder {
    var answer: String = ""
    var hint: String = ""
    var prompt: String = ""
    
    func build() throws -> Question {
        guard answer.count > 0 else { throw Error.missingAnswer}
        guard prompt.count > 0 else { throw Error.missingPrompt}
        return Question(answer: self.answer, hint: self.hint, prompt: self.prompt)
    }
    
    enum Error: String, Swift.Error {
        case missingAnswer
        case missingPrompt
    }
}


class QuestionGroupBuilder {
    
    var questions = [QuestionBuilder()]
    var title = ""
    
    
    func addNewQuestion() {
        let question = QuestionBuilder()
        questions.append(question)
    }
    
    func removeQuestion(at index: Int) {
        questions.remove(at: index)
    }
    
    
    func build() throws -> QuestionGroup {
        guard self.title.count > 0 else {
            throw Error.missingTitle
        }
        
        guard self.questions.count > 0 else {
            throw Error.missingQuestions
        }
        
        let questions = try self.questions.map { try $0.build() }
        return QuestionGroup(questions: questions, title: title)
    }
    
    public enum Error: String, Swift.Error {
        case missingTitle
        case missingQuestions
    }
    
}
