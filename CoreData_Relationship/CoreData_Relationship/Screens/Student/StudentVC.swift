//
//  StudentVC.swift
//  CoreData_Relationship
//
//  Created by PHN MAC 1 on 28/07/23.
//

import UIKit

class StudentVC: UIViewController {

    @IBOutlet weak var studentTableView: UITableView!
    var collegeEntity: CollegeEntity?
    var students: [StudentEntity] = []
    
    let coreDataHelper = CoreDataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchStudent()
    }
    
    @IBAction func addStudentBtnClick(_ sender: Any) {
        let addStudentVC: AddUpdateStudentVC = getAnyViewController(storyboardName: .main)
        addStudentVC.collegeEntity = collegeEntity
        navigationController?.pushViewController(addStudentVC, animated: true)
    }
}

extension StudentVC{
    private func fetchStudent(){
        guard let students_ = (collegeEntity?.students) else {return}
        guard let allStudents = students_.allObjects as? [StudentEntity] else {return}
        students = allStudents
        studentTableView.reloadData()
    }
}

extension StudentVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let student = students[indexPath.row]
         let cell = studentTableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = String(describing: (student.firstName ?? "") + " " + (student.lastName ?? ""))
        content.secondaryText = String(describing: student.email ?? "")
        cell.contentConfiguration = content
        return cell
    }
}


extension StudentVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.coreDataHelper.deleteStudent(studentEntity: self.students[indexPath.row])
            self.students.remove(at: indexPath.row)
            self.studentTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentDetailVC: StudentDetailVC = getAnyViewController(storyboardName: .main)
        studentDetailVC.studentEntity = students[indexPath.row]
        navigationController?.pushViewController(studentDetailVC, animated: true)
    }
}
