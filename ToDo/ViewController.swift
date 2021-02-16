//
//  ViewController.swift
//  ToDo
//
//  Created by Timo Metsälä on 15.2.2021.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let tableView = UITableView()
    var todos: [ToDo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewHierachy()
        setupViewConstraints()
        setupBarButtons()
    }

    func setupBarButtons() {
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTodo))
        let editButton = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: self, action: #selector(toggleEdit))
        navigationItem.rightBarButtonItems = [plusButton, editButton]
    }
    
    @objc func addTodo() {
        todos.append(ToDo(title: "Muista humppa!", text: "Humppaa humppaa"))
        tableView.reloadData()
    }
    
    @objc func toggleEdit() {
        tableView.isEditing = !tableView.isEditing
    }
}

extension ViewController: ViewConstructor {
    func setupViewHierachy() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupViewConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "humppa")
        var content = cell.defaultContentConfiguration()
        content.text = todos[indexPath.row].title
        cell.contentConfiguration = content
        return cell
    }
 
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moved = todos.remove(at: sourceIndexPath.row)
        todos.insert(moved, at: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todos.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoController = ToDoController(todo: todos[indexPath.row], textChanged: { (newText) in
            self.todos[indexPath.row].text = newText
        },
        titleChanged: { (newTitle) in
            self.todos[indexPath.row].title = newTitle
            self.tableView.reloadData()
        })
        self.navigationController?.pushViewController(todoController, animated: true)
    }
}
