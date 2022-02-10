//
//  CreateQuestionGroupViewController.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 10/02/2022.
//

import UIKit

 protocol CreateQuestionGroupViewControllerDelegate {

  func createQuestionGroupViewControllerDidCancel(_ viewController: CreateQuestionGroupViewController)

  func createQuestionGroupViewController(_ viewController: CreateQuestionGroupViewController,
                                         created questionGroup: QuestionGroup)
}

 class CreateQuestionGroupViewController: UITableViewController {

  // MARK: - Properties
   var delegate: CreateQuestionGroupViewControllerDelegate?
   let questionGroupBuilder = QuestionGroupBuilder()

   override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
  }

  // MARK: - IBActions
  @IBAction func cancelPressed(_ sender: Any) {
    delegate?.createQuestionGroupViewControllerDidCancel(self)
  }

  @IBAction func savePressed(_ sender: Any) {
    do {
      let questionGroup = try questionGroupBuilder.build()
      delegate?.createQuestionGroupViewController(
        self, created: questionGroup)

    } catch {
      displayMissingInputsAlert()
    }
  }

   func displayMissingInputsAlert() {
    let alert = UIAlertController(
      title: "Missing Inputs",
      message: "Please provide all non-optional values",
      preferredStyle: .alert)

    let okAction = UIAlertAction(title: "Ok",
                                 style: .default,
                                 handler: nil)
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
  }
}

// MARK: - UITableViewDataSource
extension CreateQuestionGroupViewController {

  fileprivate struct CellIdentifiers {
    fileprivate static let add = "AddQuestionCell"
    fileprivate static let title = "CreateQuestionGroupTitleCell"
    fileprivate static let question = "CreateQuestionCell"
  }

   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return questionGroupBuilder.questions.count + 2
  }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let row = indexPath.row
    if row == 0 {
      return titleCell(from: tableView, for: indexPath)
    } else if row >= 1 &&
      row <= questionGroupBuilder.questions.count {
      return self.questionCell(from: tableView, for: indexPath)
    } else {
      return addQuestionGroupCell(from: tableView, for: indexPath)
    }
  }

  private func titleCell(from tableView: UITableView,
                         for indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.title,
                                             for: indexPath) as! CreateQuestionGroupTitleCell
    cell.delegate = self
    cell.titleTextField.text = questionGroupBuilder.title
    return cell
  }

  private func  questionCell(from tableView: UITableView,
                             for indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.question,
                                             for: indexPath) as! CreateQuestionCell
    cell.delegate = self
    let questionBuilder = self.questionBuilder(for: indexPath)
    cell.delegate = self
    cell.answerTextField.text = questionBuilder.answer
    cell.hintTextField.text = questionBuilder.hint
    cell.indexLabel.text = "Question \(indexPath.row)"
    cell.promptTextField.text = questionBuilder.prompt
    return cell
  }
  
  private func questionBuilder(for indexPath: IndexPath) -> QuestionBuilder {
    return questionGroupBuilder.questions[indexPath.row - 1]
  }

  private func addQuestionGroupCell(from tableView: UITableView,
                                    for indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.add,
                                         for: indexPath)
  }
}

// MARK: - UITableViewDelegate
extension CreateQuestionGroupViewController {

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    guard isLastIndexPath(indexPath) else { return }
    questionGroupBuilder.addNewQuestion()
    tableView.insertRows(at: [indexPath], with: .top)
  }

  private func isLastIndexPath(_ indexPath: IndexPath) -> Bool {
    return indexPath.row ==
      tableView.numberOfRows(inSection: indexPath.section) - 1
  }
}

// MARK: - CreateQuestionCellDelegate
extension CreateQuestionGroupViewController: CreateQuestionCellDelegate {

   func createQuestionCell(_ cell: CreateQuestionCell,
                                 answerTextDidChange text: String) {
    questionBuilder(for: cell).answer = text
  }
  
  private func questionBuilder(for cell: CreateQuestionCell) -> QuestionBuilder  {
    let indexPath = tableView.indexPath(for: cell)!
    return questionBuilder(for: indexPath)
  }

   func createQuestionCell(_ cell: CreateQuestionCell,
                                 hintTextDidChange text: String) {
    questionBuilder(for: cell).hint = text
  }

   func createQuestionCell(_ cell: CreateQuestionCell,
                                 promptTextDidChange text: String) {
    questionBuilder(for: cell).prompt = text
  }
}

// MARK: - CreateQuestionGroupTitleCellDelegate
extension CreateQuestionGroupViewController: CreateQuestionGroupTitleCellDelegate {

   func createQuestionGroupTitleCell(_ cell: CreateQuestionGroupTitleCell,
                                           titleTextDidChange text: String) {
    questionGroupBuilder.title = text
  }
}
