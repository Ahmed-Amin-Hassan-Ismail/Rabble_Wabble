//
//  ViewController.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 01/02/2022.
//

import UIKit

protocol QuestionViewControllerDelegate: AnyObject {
    func questionViewController(_ viewController: QuestionViewController,
                                didCancel questionGroup: QuestionGroup,
                                at questionIndex: Int)
    func questionViewController(_ viewController: QuestionViewController,
                                didComplete questionGroup: QuestionGroup)
}

class QuestionViewController: UIViewController {
    
    //MARK: - Instance Variable
    var questionGroup: QuestionGroup! {
        didSet {
            navigationItem.title = questionGroup.title
        }
    }
    var questionIndex = 0
    var correctCount = 0
    var incorrectCount = 0
    weak var delegate: QuestionViewControllerDelegate?
    
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        
        return item
    }()
    
    
    public var questionView: QuestionView! {
      guard isViewLoaded else { return nil }
      return (view as! QuestionView)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCancelButton()
        self.showQuestion()
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
          delegate?.questionViewController(self, didComplete: questionGroup)
        return
      }
      showQuestion()
    }
}

//MARK: - Helper Methods
extension QuestionViewController {
    
    private func showQuestion() {
      let question = questionGroup.questions[questionIndex]
      
      questionView.answerLabel.text = question.answer
      questionView.promptLabel.text = question.prompt
      questionView.hintLabel.text = question.hint
      
      questionView.answerLabel.isHidden = true
      questionView.hintLabel.isHidden = true
        
        questionIndexItem.title = "\(questionIndex + 1)/" +
        "\(questionGroup.questions.count)"
    }
    
    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(named: "ic_menu")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
    }
    
    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        delegate?.questionViewController(self, didCancel: questionGroup, at: questionIndex)
    }
}

