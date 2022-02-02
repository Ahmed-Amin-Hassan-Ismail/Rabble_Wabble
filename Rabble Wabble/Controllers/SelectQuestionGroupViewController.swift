//
//  SelectQuestionGroupViewController.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 01/02/2022.
//

import UIKit

class SelectQuestionGroupViewController: UIViewController {
    
    //MARK: - Properties
    private let questionGroups = QuestionGroup.allGroups()
    private var selectedQuestionGroup: QuestionGroup!
    
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
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectQuestionGroup" {
            guard let questionViewController = segue.destination as? QuestionViewController else { return }
            questionViewController.delegate = self
            questionViewController.questionStrategy = RandomQuestionStrategy(questionGroup: selectedQuestionGroup)
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
