//
//  TaskViewController.swift
//  Todo_2012728
//
//  Created by english on 2020-12-14.
//  Copyright © 2020 rahulpipaliya. All rights reserved.
//

import Foundation

import UIKit


class TaskViewController: UIViewController , UITextFieldDelegate  {

    var delegate : taskDelegate?
    
    @IBOutlet weak var TaskName: UITextField!
    @IBOutlet weak var TaskPriority: UITextField!
   
    @IBOutlet weak var errorLabel: UILabel!
    var tasksArr : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskPriority.keyboardType = .numberPad
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func addTaskButton(_ sender: UIButton) {

        //getting task name , trimming it
        let taskName :String = TaskName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var errors : String = ""
        
        //getting priority
        let taskPriority : Int = Int(TaskPriority.text!) ?? -1

        let task :String = taskName+"-"+String(taskPriority)

        if taskName.count < 0 {
            errors += " Name Can Not be empty "
        }
        
        if taskPriority <= 0 , taskPriority > 5 {
            errors += " Priority Should be in range of  1-5 "
        }

        
        
        if taskName.count > 0 ,  taskPriority > 0 , taskPriority <= 5  {
            if let delagate = delegate {
                       delagate.taskAdded(task: task)
                   }
                   _ = navigationController?.popToRootViewController(animated: true)
        }else{
            errorLabel.text = errors;
        }
    }
}

protocol taskDelegate {
    func taskAdded(task : String)
}
