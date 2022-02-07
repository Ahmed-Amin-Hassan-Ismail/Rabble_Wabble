//
//  QuestionGroupCaretaker.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 05/02/2022.
//

import Foundation


final class QuestionGroupCaretaker {
    
    let fileName: String = "QuestionGroupData"
    var questionGroups: [QuestionGroup] = []
    var selectedQuestionGroup: QuestionGroup!
    
    init() {
        self.loadQuestionGroups()
    }
    
    private func loadQuestionGroups() {
        if let questionGroups = try? DiskCaretaker.retrieve([QuestionGroup].self, from: fileName) {
            self.questionGroups = questionGroups
        } else {
            let bundle = Bundle.main
            let url = bundle.url(forResource: fileName, withExtension: "json")!
            self.questionGroups = try! DiskCaretaker.retrieve([QuestionGroup].self, from: url)
            try! save()
        }
    }
    
    func save() throws {
        try DiskCaretaker.save(questionGroups, to: fileName)
        
    }
}
