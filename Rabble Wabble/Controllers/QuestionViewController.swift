//
//  ViewController.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 01/02/2022.
//

import UIKit

class QuestionViewController: UIViewController {
    
    //MARK: - Instance Variable
    var questionGroup = QuestionGroup.basicPhrases()
    var questionIndex = 0
    
    var correctCount = 0
    var incorrectCount = 0
    
    public var questionView: QuestionView! {
      guard isViewLoaded else { return nil }
      return (view as! QuestionView)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    private func showQuestion() {
      let question = questionGroup.questions[questionIndex]
      
      questionView.answerLabel.text = question.answer
      questionView.promptLabel.text = question.prompt
      questionView.hintLabel.text = question.hint
      
      questionView.answerLabel.isHidden = true
      questionView.hintLabel.isHidden = true
    }
    
    // MARK: - Actions
    @IBAction func toggleAnswerLabels(_ sender: Any) {
      questionView.answerLabel.isHidden =
        !questionView.answerLabel.isHidden
      questionView.hintLabel.isHidden =
        !questionView.hintLabel.isHidden
    }
    
    @IBAction func handleCorrect(_ sender: Any) {
      correctCount += 1
      questionView.correctCountLabel.text = "\(correctCount)"
      showNextQuestion()
    }
    
    @IBAction func handleIncorrect(_ sender: Any) {
      incorrectCount += 1
      questionView.incorrectCountLabel.text = "\(incorrectCount)"
      showNextQuestion()
    }
    
    private func showNextQuestion() {
      questionIndex += 1
      guard questionIndex < questionGroup.questions.count else {
        // TODO: - Handle this...!
        return
      }
      showQuestion()
    }
    
    
}

