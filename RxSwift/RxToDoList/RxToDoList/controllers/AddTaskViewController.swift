//
//  AddTaskViewController.swift
//  RxToDoList
//
//  Created by Asif on 5/1/22.
//

import UIKit
import RxSwift
import RxCocoa

class AddTaskViewController: UIViewController {

    @IBOutlet weak var segmentedControl : UISegmentedControl!
    @IBOutlet weak var taskTextField : UITextField!
    
    let taskSubject = PublishSubject<Task>()
    var taskSubjectObservable : Observable<Task> {
        return taskSubject.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveData(){
        guard let priority = Priority(rawValue: self.segmentedControl.selectedSegmentIndex), let title = self.taskTextField.text else{
            return
        }
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
