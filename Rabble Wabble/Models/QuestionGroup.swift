//
//  QuestionGroup.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 01/02/2022.
//

import Foundation
import Combine



//MARK: - Originator
//MARK: -
class QuestionGroup: Codable {
    
    class Score: Codable {
        
        private enum CodingKeys: String, CodingKey {
            case correctCount
            case incorrectCount
        }
        
        var correctCount: Int = 0 {
            didSet {
                updateRunningPercentage()
            }
        }
        var incorrectCount: Int = 0 {
            didSet {
                updateRunningPercentage()
            }
        }
        @Published var runningPercentage: Double = 0
        
        init() { }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.correctCount = try container.decode(Int.self, forKey: .correctCount)
            self.incorrectCount = try container.decode(Int.self, forKey: .incorrectCount)
            self.updateRunningPercentage()
        }
        
        private func updateRunningPercentage() {
            let totalCount = correctCount + incorrectCount
            guard totalCount > 0 else {
                runningPercentage = 0
                return
            }
            runningPercentage = Double(correctCount) / Double(incorrectCount)
        }
        
        func reset() {
            self.correctCount = 0
            self.incorrectCount = 0
        }
        
    }
   
    let questions: [Question]
    private(set) var score: Score
    let title: String
    
    
    
    init(questions: [Question], score: Score = Score(), title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
}
