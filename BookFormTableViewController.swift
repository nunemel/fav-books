//
//  BookFormTableViewController.swift
//  FavoriteBooks
//
//  Created by Nune Melikyan on 13.09.22.
//

import UIKit

final class BookFormTableViewController: UITableViewController {

    var book: Book?
    
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var authorTextField: UITextField!
    @IBOutlet weak private var genreTextField: UITextField!
    @IBOutlet weak private var lengthTextField: UITextField!
    @IBOutlet weak private var titlErrorLabel: UILabel!
    @IBOutlet weak private var authorErrorLabel: UILabel!
    @IBOutlet weak private var genreErrorLabel: UILabel!
    @IBOutlet weak private var lengthErrorLabel: UILabel!
    
    init?(coder: NSCoder, book: Book?) {
        self.book = book
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.book = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    // MARK: - Field check
    @objc func isLengthNumber() -> Bool {
        if !lengthTextField.text!.isNumber || lengthTextField.text!.isEmpty {
            lengthErrorLabel.text = "Length must be a number."
            return false
        } else {
            lengthErrorLabel.text = ""
            return true
        }
    }
    
    @objc func isFieldEmpty(textField: UITextField, errorLabel: UILabel) -> Bool {
        if let textField = textField.text {
            if textField.isEmpty {
                errorLabel.text = "TextField is empty."
                return true
            } else {
                errorLabel.text = ""
                return false
            }
        }
        return false
    }
    
    func updateView() {
        lengthTextField.addTarget(self, action: #selector(isLengthNumber), for: .editingChanged)
        titleTextField.addTarget(self, action: #selector(isFieldEmpty(textField:errorLabel:)), for: .editingChanged)
        
        if !isLengthNumber() {
            return
        }
        
        if isFieldEmpty(textField: titleTextField, errorLabel: titlErrorLabel) {
            return
        }
        
        guard let book = book else {return}
        print("book \(book)")
        titleTextField.text = book.title
        
        authorTextField.text = book.author
        genreTextField.text = book.genre
        lengthTextField.text = book.length
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let title = titleTextField.text,
            let author = authorTextField.text,
            let genre = genreTextField.text,
            let length = lengthTextField.text
        else { return }
        
        if !isLengthNumber() {
            return
        }
        
        if isFieldEmpty(textField: titleTextField, errorLabel: titlErrorLabel) {
            return
        }
        
        book = Book(title: title, author: author, genre: genre, length: length)
        performSegue(withIdentifier: "UnwindToBookTable", sender: self)
    }
}

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
