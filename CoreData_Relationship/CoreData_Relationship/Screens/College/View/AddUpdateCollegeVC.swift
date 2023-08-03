//
//  AddUpdateCollegeVC.swift
//  CoreData_Relationship
//
//  Created by PHN MAC 1 on 11/07/23.
//

import UIKit

class AddUpdateCollegeVC: UIViewController {
// MARK: - IBOutlets
    @IBOutlet weak var txtCollegeName: UITextField!
    @IBOutlet weak var txtCollegeAddress: UITextField!
    @IBOutlet weak var txtCollegeUniversity: UITextField!
    @IBOutlet weak var addUpdateBtn: UIButton!
    
    let coreDataHelper = CoreDataManager()
    var isUpdate: Bool = false
    var collegeEntity: CollegeEntity?
    
// MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    
// MARK: - IBActions
    @IBAction func addUpdateBtnAction(_ sender: Any) {
        let validate = checkValidation()
        if !validate.0 { return }  // validation in false return
        
        if isUpdate{
            //update record here
            guard let collegeEntity else {return}
            coreDataHelper.updateCollge(college: validate.1, collegeEntity: collegeEntity)
        }
        else {
            //add new record here
            coreDataHelper.saveCollege(college: validate.1)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Methods
extension AddUpdateCollegeVC{
    private func checkValidation() -> (Bool, CollegeModel){
        guard let collgeName = txtCollegeName.text, collgeName != "" else{
            return (false, CollegeModel())
        }
        guard let collgeAddress = txtCollegeAddress.text, collgeAddress != "" else{
            return (false, CollegeModel())
        }
        guard let collgeUniversity = txtCollegeUniversity.text, collgeUniversity != "" else{
            return (false, CollegeModel())
        }
        let college = CollegeModel(
            name : collgeName,
            address: collgeAddress,
            university: collgeUniversity)
        return (true, college)
    }
    
    private func configuration(){
        if isUpdate{
            //for update view configuration
            self.title = "Update College"
            self.addUpdateBtn.setTitle("Update", for: .normal)
            guard let collegeEntity else {return}
            txtCollegeName.text = collegeEntity.name
            txtCollegeAddress.text = collegeEntity.address
            txtCollegeUniversity.text = collegeEntity.university
        }
        else {
            //for new add record configuration
            self.title = "Add College"
            self.addUpdateBtn.setTitle("Add", for: .normal)
        }
    }
}



