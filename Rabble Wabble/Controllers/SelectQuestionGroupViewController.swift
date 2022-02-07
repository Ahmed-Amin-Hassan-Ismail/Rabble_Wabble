//
//  SelectQuestionGroupViewController.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 01/02/2022.
//

import UIKit

class SelectQuestionGroupViewController: UIViewController {
    
    //MARK: - Properties
    private let questionGroupCaretaker = QuestionGroupCaretaker()
    private var questionGroups: [QuestionGroup] {
        return questionGroupCaretaker.questionGroups
    }
    private var selectedQuestionGroup: QuestionGroup! {
        get {
            return questionGroupCaretaker.selectedQuestionGroup
        } set {
            questionGroupCaretaker.selectedQuestionGroup = newValue
        }
    }
    private let appSettings = AppSettings.shared
   
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
           
        }
    }
    
    private func initializeTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView()
        questionGroups.forEach {
            print("\($0.title): " +
              "correctCount \($0.score.correctCount), " +
              "incorrectCount \($0.score.incorrectCount)"
            )
          }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectQuestionGroup" {
            guard let questionViewController = segue.destination as? QuestionViewController else { return }
            questionViewController.delegate = self
            questionViewController.questionStrategy = appSettings.questionStrategy(for: questionGroupCaretaker)
        }
    }
    
}

//MARK: - TableView DataSource
extension SelectQuestionGroupViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell", for: indexPath) as! QuestionGroupCell
        let questionGroup = questionGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        
        return cell
    }
    
    
}

//MARK: - TableView Delegate
extension SelectQuestionGroupViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroups[indexPath.row]
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - QuestionViewControllerDelegate
extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {
    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionStrategy) {
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionStrategy) {
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    
}
