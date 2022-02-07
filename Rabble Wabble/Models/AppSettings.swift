//
//  AppSettings.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 05/02/2022.
//

import Foundation

// this to manage app-wide settings


class AppSettings {
    
    // store setting in userDefaults
    private struct Keys {
        static let questionStrategy = "questionStrategy"
    }
    
    // Select Strategy Type
    enum QuestionStrategyType: Int, CaseIterable {
        case random
        case sequental
        
        func title() -> String {
            switch self {
            case .random:
                return "Random"
            case .sequental:
                return "Sequential"
            }
        }
        
        func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy {
            switch self {
            case .random:
                return RandomQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
            case .sequental:
                return SequentialQuestionStrategy(questionGroupCaretaker: questionGroupCaretaker)
            }
        }
    }
    
    static let shared = AppSettings()
    
    var questionStrategyType: QuestionStrategyType {
        get {
            let rawValue = UserDefaults.standard.integer(forKey: Keys.questionStrategy)
            return QuestionStrategyType(rawValue: rawValue)!
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Keys.questionStrategy)
        }
    }
    
    private init() { }
    
    
    func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy {
        return questionStrategyType.questionStrategy(for: questionGroupCaretaker)
    }
    
    
    
    
}
