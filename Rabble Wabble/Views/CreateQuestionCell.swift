//
//  CreateQuestionCell.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 10/02/2022.
//

import UIKit

// MARK: - CreateQuestionCellDelegate
protocol CreateQuestionCellDelegate {
    func createQuestionCell(_ cell: CreateQuestionCell, answerTextDidChange text: String)
    func createQuestionCell(_ cell: CreateQuestionCell, hintTextDidChange text: String)
    func createQuestionCell(_ cell: CreateQuestionCell, promptTextDidChange text: String)
}

// MARK: - CreateQuestionCell
class CreateQuestionCell: UITableViewCell {
    
    var delegate: CreateQuestionCellDelegate?
    
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var hintTextField: UITextField!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var promptTextField: UITextField!
}

// MARK: - IBActions
extension CreateQuestionCell {
    @IBAction func answerTextFieldDidChange(_ textField: UITextField) {
        delegate?.createQuestionCell(self, answerTextDidChange: textField.text!)
    }
    
    @IBAction func hintTextFieldDidChange(_ textField: UITextField) {
        delegate?.createQuestionCell(self, hintTextDidChange: textField.text!)
    }
    
    @IBAction func promptTextFieldDidChange(_ textField: UITextField) {
        delegate?.createQuestionCell(self, promptTextDidChange: textField.text!)
    }
}

// MARK: - UITextFieldDelegate
extension CreateQuestionCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
