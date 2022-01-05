//
//  TaskListViewController.swift
//  RxToDoList
//
//  Created by Asif on 27/12/21.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var prioritySegmentedControl : UISegmentedControl!
    @IBOutlet weak var tableView : UITableView!
    let tableCellId = "taskTableCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    

    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath)
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
