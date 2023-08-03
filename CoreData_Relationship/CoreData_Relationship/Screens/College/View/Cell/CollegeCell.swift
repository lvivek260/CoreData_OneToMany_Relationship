//
//  CollegeCell.swift
//  CoreData_Relationship
//
//  Created by PHN MAC 1 on 11/07/23.
//

import UIKit

class CollegeCell: UITableViewCell {

// MARK: - IBOutlets
    @IBOutlet weak var lblCollegeName: UILabel!
    @IBOutlet weak var lblUniversityName: UILabel!

    var collegeEntity: CollegeEntity?{
        didSet{ configuration() }
    }

// MARK: - Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

// MARK: - Configurations
    private func configuration(){
        guard let collegeEntity else { return }
        lblCollegeName.text = collegeEntity.name
        lblUniversityName.text = collegeEntity.university
    }
}


