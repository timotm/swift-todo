//
//  ToDoController.swift
//  
//
//  Created by Timo Metsälä on 15.2.2021.
//

import UIKit
import SnapKit

class ToDoController: UIViewController {
    let todoTitle = UITextField()
    let text = UITextView()
    let todo: ToDo
    let textChanged: (String) -> ()
    let titleChanged: (String) -> ()
    
    init(todo: ToDo, textChanged: @escaping (String)  -> (), titleChanged: @escaping (String) -> ()) {
        self.todo = todo
        self.textChanged = textChanged
        self.titleChanged = titleChanged
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.text = self.todo.text
        todoTitle.text = self.todo.title
        text.delegate = self
        todoTitle.delegate = self
        setupViewHierachy()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ToDoController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.textChanged(textView.text)
    }
}

extension ToDoController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.titleChanged(textField.text ?? "")
    }
}

extension ToDoController: ViewConstructor {
    
    func setupViewHierachy() {
        text.backgroundColor = .white
        view.addSubview(text)
        todoTitle.backgroundColor = .white
        view.addSubview(todoTitle)
    }
    
    func setupViewConstraints() {
        todoTitle.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        text.snp.makeConstraints { (make) in
            make.top.equalTo(todoTitle.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
