//
//  TasksViewController.swift
//  FirebaseToDo
//
//  Created by Artjoms Vorona on 09/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase
import UIKit

class TasksViewController: UIViewController {
    
    var user: Users!
    var ref: DatabaseReference!
    var tasks = [Tasks]()

    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUser = Auth.auth().currentUser else { return }
        user = Users(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        ref.observe(.value, with: { (snapshot) in
            var newTask = [Tasks]()
            for item in snapshot.children {
                let task = Tasks(snapshot: item as! DataSnapshot)
                newTask.append(task)
            }
            self.tasks = newTask
            self.taskTableView.reloadData()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        ref.removeAllObservers()
    }
    
    @IBAction func addItemTapped(_ sender: Any) {
        let alert = UIAlertController(title: "New ToDo task", message: "Add new", preferredStyle: .alert)
        alert.addTextField()
        let saveButton = UIAlertAction(title: "Save", style: .default) { (_) in
            guard let textField = alert.textFields?.first, textField.text != "" else { return }
            
            let task = Tasks(title: textField.text!, userId: self.user.uid)
            let taskRef = self.ref.child(task.title.lowercased())
            taskRef.setValue(task.convertToDict())
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logoutItemTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            print("leaving")
        } catch let signOutError {
            print("Failed ot sing out ", signOutError)
        }
        self.dismiss(animated: true, completion: nil)
    }

    func toggleCompletion(_ cell: UITableViewCell, isCompleted: Bool) {
        cell.accessoryType = isCompleted ? .checkmark : .none
    }
    
}//end class

extension TasksViewController: UITableViewDelegate,  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FireCell", for: indexPath)
        
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        
        toggleCompletion(cell, isCompleted: task.completed)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            task.ref?.removeValue()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let task = tasks[indexPath.row]
        let isCompleted  = !task.completed
        
        toggleCompletion(cell, isCompleted: isCompleted)
        task.ref?.updateChildValues(["completed": isCompleted])
    }
    
}//end extensions
