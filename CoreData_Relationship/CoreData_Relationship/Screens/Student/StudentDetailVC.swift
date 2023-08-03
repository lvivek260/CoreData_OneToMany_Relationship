//
//  StudentDetailVC.swift
//  CoreData_Relationship
//
//  Created by PHN MAC 1 on 28/07/23.
//

import UIKit

class StudentDetailVC: UIViewController {

// MARK: - IBOutlets
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    var studentEntity: StudentEntity?

// MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        uiConfiguration()
    }
    
// MARK: - IBActions
    @IBAction func editBtnClick(_ sender: Any) {
        let editStudentVC: AddUpdateStudentVC = getAnyViewController(storyboardName: .main)
        editStudentVC.isUpdate = true
        editStudentVC.studentEntity = studentEntity
        navigationController?.pushViewController(editStudentVC, animated: true)
    }
}


extension StudentDetailVC{
    private func uiConfiguration(){
        guard let studentEntity else {return}
        firstNameLbl.text = "First Name:- " + (studentEntity.firstName ?? "")
        lastNameLbl.text = "Last Name:- " + (studentEntity.lastName ?? "")
        emailLbl.text = "Email Id:- " + (studentEntity.email ?? "")
    }
}
