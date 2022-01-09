//
//  TaskListViewController.swift
//  RxToDoList
//
//  Created by Asif on 27/12/21.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var prioritySegmentedControl : UISegmentedControl!
    @IBOutlet weak var tableView : UITableView!
    let tableCellId = "taskTableCell"
    let disposeBag = DisposeBag()
    private var filteredTaskList = [Task]()
    private var taskList = BehaviorRelay<[Task]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    

    
    private func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func filterTask(by priority : Priority?){
        if(priority == nil){
            self.filteredTaskList = self.taskList.value
            print("All priority selected")
        }
        else{
            self.taskList.map{task in
                task.filter{
                    return $0.priority == priority!
                }
            }.subscribe(onNext:{[weak self] tasks in
                self?.filteredTaskList = tasks
                print(self?.filteredTaskList ?? "no task found")
            }).disposed(by: disposeBag)
        }
    }
    
    @IBAction func didChangePrioritySegment(segmentControl : UISegmentedControl){
        let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
        self.filterTask(by: priority)
        
    }
    
    // MARK: - TableView Delegates and DataSources
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath)
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("TaskListVC segue")
        guard let navC = segue.destination as? UINavigationController,
              let addTaskVc = navC.viewControllers.first as? AddTaskViewController else{
            fatalError("Destination not found")
        }
        addTaskVc.taskSubjectObservable.subscribe(onNext: {[unowned self]task in
            print(task)
            let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
            var currentTasks = self.taskList.value
            currentTasks.append(task)
            self.taskList.accept(currentTasks)
            self.filterTask(by: priority)
        }).disposed(by: disposeBag)
        
    }
    

}
