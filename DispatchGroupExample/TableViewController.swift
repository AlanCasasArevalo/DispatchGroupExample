//
//  TableViewController.swift
//  DispatchGroupExample
//
//  Created by Alan Casas on 5/12/18.
//  Copyright © 2018 Alan Casas. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let groupA = ["Usuario1", "Usuario2", "Usuario3"]
    let groupB = ["Usuario4", "Usuario5", "Usuario6"]
    let groupC = ["Usuario7", "Usuario8", "Usuario9"]
    
    var users = [String]()
    
    let dispatchGroup = DispatchGroup()
    
    func runDispatch (after seconds: Int, completion: @escaping () -> ()) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    func getGroupA() {
        
        dispatchGroup.enter()
        runDispatch(after: 1) {
            print("group A")
            self.users.append(contentsOf: self.groupA)
            self.dispatchGroup.leave()
        }
    }
    
    func getGroupB() {
        dispatchGroup.enter()
        runDispatch(after: 1) {
            print("group B")
            self.users.append(contentsOf: self.groupB)
            self.dispatchGroup.leave()
        }
    }
    
    func getGroupC() {
        dispatchGroup.enter()
        runDispatch(after: 1) {
            print("group C")
            self.users.append(contentsOf: self.groupC)
            self.tableView.reloadData()
            self.dispatchGroup.leave()
        }
    }
    
    func displayUsers() {
        print("reloading data")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = users[indexPath.row]
        return cell 
    }
    
    @IBAction func downlLoadUsers(_ sender: UIBarButtonItem) {
        self.getGroupC()
        self.getGroupA()
        self.getGroupB()

        dispatchGroup.notify(queue: .main) {
            self.displayUsers()
        }
    }    

}
