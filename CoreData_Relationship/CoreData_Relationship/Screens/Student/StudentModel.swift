//
//  StudentModel.swift
//  CoreData_Relationship
//
//  Created by PHN MAC 1 on 27/07/23.
//

import Foundation

struct StudentModel{
    let firstName: String
    let lastName: String
    let email: String
    
    init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    init(){
        self.firstName = ""
        self.lastName = ""
        self.email = ""
    }
}
