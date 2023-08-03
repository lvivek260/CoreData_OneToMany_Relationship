//
//  ViewController.swift
//  CoreData_Relationship
//
//  Created by PHN MAC 1 on 11/07/23.
//

import UIKit

class CollegeVC: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var collegeTableView: UITableView!
    let coreDataHelper = CoreDataManager()
    var colleges: [CollegeEntity] = []
    
// MARK: - View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchCollegeData()
    }
}

// MARK: - Configurations
extension CollegeVC{
    private func configuration(){
        //TableView Configuration
        collegeTableView.register(CollegeCell.nib, forCellReuseIdentifier: CollegeCell.id)
    }
    private func fetchCollegeData(){
        self.colleges = coreDataHelper.fetchCollege()
        self.collegeTableView.reloadData()
    }
}

// MARK: - UITableView Data Source
extension CollegeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = collegeTableView.dequeueReusableCell(withIdentifier: CollegeCell.id, for: indexPath) as? CollegeCell else{
            return UITableViewCell()
        }
        cell.collegeEntity = colleges[indexPath.row]
        return cell
    }
}

// MARK: - UITableView Delegate
extension CollegeVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collegeDetailVC: CollegeDetailVC = getAnyViewController(storyboardName: .main)
        collegeDetailVC.collegeEntity = self.colleges[indexPath.row]
        self.navigationController?.pushViewController(collegeDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.coreDataHelper.deleteCollege(collegeEntity: self.colleges[indexPath.row])
            self.colleges.remove(at: indexPath.row)
            self.collegeTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
