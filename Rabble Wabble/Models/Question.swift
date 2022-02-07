//
//  Question.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 01/02/2022.
//

import Foundation



class Question: Codable {
  let answer: String
  let hint: String?
  let prompt: String
    
    init(answer: String, hint: String?, prompt: String) {
        self.answer = answer
        self.hint = hint
        self.prompt = prompt
    }
}
