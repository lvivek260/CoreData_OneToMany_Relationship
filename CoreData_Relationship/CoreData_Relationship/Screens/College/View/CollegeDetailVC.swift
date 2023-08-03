//
//  CollegeDetailVC.swift
//  CoreData_Relationship
//
//  Created by PHN MAC 1 on 11/07/23.
//

import UIKit

class CollegeDetailVC: UIViewController {
// MARK: - IBOutlets
    @IBOutlet weak var lblCollegeName: UILabel!
    @IBOutlet weak var lblCollegeAddress: UILabel!
    @IBOutlet weak var lblCollegeUniversity: UILabel!
    @IBOutlet weak var numberOfStudentBtn: UIButton!

    var collegeEntity: CollegeEntity?
    
// MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        configuration()
    }

// MARK: - IBActions
    @IBAction func numberOfStudentBtnClick(_ sender: Any) {
        //Go to Students VC
        guard let collegeEntity else {return}
        let studentVC: StudentVC = getAnyViewController(storyboardName: .main)
        studentVC.collegeEntity = collegeEntity
        navigationController?.pushViewController(studentVC, animated: true)
    }
}

// MARK: - Configurations
extension CollegeDetailVC{
    private func configuration(){
        //Set Default Value
        self.title = "College Detail"
        guard let collegeEntity else {return}
        lblCollegeName.text = "Name:- \(collegeEntity.name ?? "")"
        lblCollegeAddress.text = "Address:- \(collegeEntity.address ?? "")"
        lblCollegeUniversity.text = "University:- \(collegeEntity.university ?? "")"
        
        //add Navigaiton button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
    }
    //go to edit view controller
    @objc private func editButtonTapped(){
        let editVC = self.storyboard?.instantiateViewController(identifier: AddUpdateCollegeVC.id) as! AddUpdateCollegeVC
        editVC.isUpdate = true
        editVC.collegeEntity = collegeEntity
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}
