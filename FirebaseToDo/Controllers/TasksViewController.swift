//
//  TasksViewController.swift
//  FirebaseToDo
//
//  Created by Artjoms Vorona on 09/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addItemTapped(_ sender: Any) {
    
    }
    
    @IBAction func logoutItemTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}//end classs

extension TasksViewController: UITableViewDelegate,  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FireCell", for: indexPath)
        
        cell.textLabel?.text = "This is cell number: \(indexPath.row)"
        
        return cell
    }
    
    
}
