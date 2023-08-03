//
//  AddUpdateStudentVC.swift
//  CoreData_Relationship
//
//  Created by PHN MAC 1 on 28/07/23.
//

import UIKit

class AddUpdateStudentVC: UIViewController {
   
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var emailidTxt: UITextField!
    
    var collegeEntity: CollegeEntity?
    var studentEntity: StudentEntity?
    let coreDataHelper = CoreDataManager()
    var isUpdate: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
    @IBAction func saveBtnClick(_ sender: Any) {
        let result = checkValidation()
        if !result.0{ return }
        
        if isUpdate{ //update student here
            guard let studentEntity else {return}
            coreDataHelper.editStudent(student: result.1, studentEntity: studentEntity)
        }
        else{ //new student add here
            guard let collegeEntity else {return}
            coreDataHelper.saveStudent(student: result.1, collegeEntity: collegeEntity)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Methods
extension AddUpdateStudentVC{
    private func configuration(){
        guard let studentEntity else {return}
        if isUpdate{
            firstNameTxt.text = studentEntity.firstName
            lastNameTxt.text = studentEntity.lastName
            emailidTxt.text = studentEntity.email
            self.title = "Update Student"
        }
        else{
            self.title = "Add Student"
        }
    }
    
    private func checkValidation()->(Bool, StudentModel){
        guard let firstName = firstNameTxt.text, firstName != "" else {
            showAlert("First Name should not be empty")
            return (false, StudentModel())
        }
        guard let lastName = lastNameTxt.text, lastName != "" else {
            showAlert("Last Name should not be empty")
            return (false, StudentModel())
        }
        guard let email = emailidTxt.text, email != "" else {
            showAlert("Email id should not be empty")
            return (false, StudentModel())
        }
        return (true, StudentModel(firstName: firstName, lastName: lastName, email: email))
    }
}
