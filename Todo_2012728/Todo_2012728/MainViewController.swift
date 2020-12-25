//
//  MainViewController.swift
//  Todo_2012728
//
//  Created by english on 2020-12-14.
//  Copyright © 2020 rahulpipaliya. All rights reserved.
//

import Foundation

import UIKit

class MainViewController: UITableViewController  {
    
    
    

    var tasks : [String] = []
    var task : String = ""
    var priority : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //dummy data as "Task - Priority Number"
        tasks = ["Laundry-2" , "Dishes-3" , "Shopping-4"];
        
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TaskViewController{
            vc.delegate = self
            vc.tasksArr = tasks
        }
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //if row is selected then unselect else select row to
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        
        //fill the table
        cell.textLabel?.text = tasks[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        //if task is selected means completed then show delete slider
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            return .delete
        }
        return .none
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt index: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            //remove from tasks array
            tasks.remove(at: index.row)
            //remove from table row
            tableView.deleteRows(at: [index], with: .fade)
            
            tableView.endUpdates()
        }
    }
        
}


	

extension MainViewController : taskDelegate{
    func taskAdded(task: String) {
        
        //add task to array
        tasks.append(task)
    
        tasks.sort(by: { (value1: String, value2: String) -> Bool in
            
            //extracting Task and priorities
            let taskArr1 = value1.components(separatedBy: "-")
            let taskArr2 = value2.components(separatedBy: "-")
            
            //if priority is same then sort by alphabets
            if taskArr1[1] == taskArr2[1]{
                return taskArr1[0] < taskArr2[0]
            }
            
    
            return taskArr1[1] < taskArr2[1]
         })
 
        self.tableView.reloadData()
    }
}
