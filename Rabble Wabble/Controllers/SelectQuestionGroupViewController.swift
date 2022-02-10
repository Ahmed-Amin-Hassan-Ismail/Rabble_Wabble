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
        
        if let viewController =
            segue.destination as? QuestionViewController {
            viewController.questionStrategy =
            appSettings.questionStrategy(for: questionGroupCaretaker)
            viewController.delegate = self
            
        } else if let navController =
                    segue.destination as? UINavigationController,
                  let viewController =
                    navController.topViewController as? CreateQuestionGroupViewController {
            viewController.delegate = self
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
        cell.percentageSubscriber = questionGroup.score.$runningPercentage
            .receive(on: DispatchQueue.main)
            .map() { number in
                return String(format: "%.0f %%", round(100 * number))
            }
            .assign(to: \.text, on: cell.percentageLabel)
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

//MARK: - CreateQuestionGroupViewControllerDelegate
extension SelectQuestionGroupViewController: CreateQuestionGroupViewControllerDelegate {
    func createQuestionGroupViewControllerDidCancel(_ viewController: CreateQuestionGroupViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func createQuestionGroupViewController(_ viewController: CreateQuestionGroupViewController, created questionGroup: QuestionGroup) {
        questionGroupCaretaker.questionGroups.append(questionGroup)
        try? questionGroupCaretaker.save()
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
    
    
}
