//
//  UITableView+Extension.swift
//  CoreData_Relationship
//
//  Created by PHN MAC 1 on 11/07/23.
//

import UIKit

extension UITableViewCell{
    static var id: String {return String(describing: self)}
    static var nib: UINib {return UINib(nibName: self.id, bundle: nil)}
}
