//
//  CreateQuestionGroupTitleCell.swift
//  Rabble Wabble
//
//  Created by Ahmed Amin on 10/02/2022.
//

import UIKit

// MARK: - CreateQuestionCellDelegate
protocol CreateQuestionGroupTitleCellDelegate {
    func createQuestionGroupTitleCell(_ cell: CreateQuestionGroupTitleCell,
                                      titleTextDidChange text: String)
}

// MARK: - CreateQuestionGroupTitleCell
class CreateQuestionGroupTitleCell: UITableViewCell {
    
    var delegate: CreateQuestionGroupTitleCellDelegate?
    
    @IBOutlet var titleTextField: UITextField!
}

// MARK: - IBActions
extension CreateQuestionGroupTitleCell {
    
    @IBAction func titleTextFieldDidChange(_ textField: UITextField) {
        delegate?.createQuestionGroupTitleCell(self, titleTextDidChange: textField.text!)
    }
}

// MARK: - UITextFieldDelegate
extension CreateQuestionGroupTitleCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
