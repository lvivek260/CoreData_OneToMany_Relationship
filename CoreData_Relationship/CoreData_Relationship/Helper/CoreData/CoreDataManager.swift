//
//  CoreDataManager.swift
//  CoreData_Relationship
//
//  Created by PHN MAC 1 on 11/07/23.
//

import UIKit
import CoreData

final class CoreDataManager{
    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    
// MARK: - College Data operation
    //for save college data
    func saveCollege(college: CollegeModel){
        let collegeEntity = CollegeEntity(context: context)
        setCollegeValue(collegeEntity: collegeEntity,college: college)
    }
    
    //for get College data
    func fetchCollege() -> [CollegeEntity]{
        var colleges: [CollegeEntity] = []
        do{
            colleges = try context.fetch(NSFetchRequest(entityName: "CollegeEntity"))
        }
        catch let error{
            print("College Data fetching error:-",error.localizedDescription)
        }
        return colleges
    }
    
    //for update College data
    func updateCollge(college: CollegeModel, collegeEntity: CollegeEntity){
        setCollegeValue(collegeEntity: collegeEntity, college: college)
    }
    
    //for delete college data
    func deleteCollege(collegeEntity: CollegeEntity){
        context.delete(collegeEntity)
        saveContext()
    }
    
    
// MARK: - Student Operations
    //save student
    func saveStudent(student: StudentModel, collegeEntity: CollegeEntity){
        let studentEntity = StudentEntity(context: context)
        studentEntity.firstName = student.firstName
        studentEntity.lastName = student.lastName
        studentEntity.email = student.email
        studentEntity.college = collegeEntity
        saveContext()
    }
    
    //get all colleges students
    func getAllStudent()->[StudentEntity]{
        var students: [StudentEntity] = []
        do{
            students = try context.fetch(NSFetchRequest(entityName: "StudentEntity"))
        }
        catch let error{
            print("College Data fetching error:-",error.localizedDescription)
        }
        return students
    }
    
    //edit particular student
    func editStudent(student: StudentModel, studentEntity: StudentEntity){
        studentEntity.firstName = student.firstName
        studentEntity.lastName = student.lastName
        studentEntity.email = student.email
        saveContext()
    }
    
    //delete student
    func deleteStudent(studentEntity: StudentEntity){
        context.delete(studentEntity)
        saveContext()
    }

    
// MARK: - Others common Function
    private func setCollegeValue(collegeEntity: CollegeEntity, college: CollegeModel){
        collegeEntity.name = college.name
        collegeEntity.address = college.address
        collegeEntity.university = college.university
        saveContext()
    }
    
    private func saveContext(){
        do{
            try context.save()
        }
        catch let err{
            print("Data Saving Error:-",err.localizedDescription)
        }
    }
}
