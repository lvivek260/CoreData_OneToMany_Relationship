//
//  UIViewController+ Extension.swift
//  CoreData_Relationship
//
//  Created by PHN MAC 1 on 11/07/23.
//

import UIKit

enum Storyboard: String{
    case main = "Main"
}

extension UIViewController{
    func showAlert(_ message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okeyBtn = UIAlertAction(title: "Okey", style: .cancel)
        alert.addAction(okeyBtn)
        self.present(alert, animated: true)
    }
}

extension UIViewController{
    static var id: String {return String(describing: self)}
    
    //USE:- let nextVC: DestinationViewController = getAnyViewController
    func getAnyViewController<T: UIViewController>(storyboardName: Storyboard) -> T{
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: T.id) as? T else {
            print(T.id + " Not Present in " + storyboardName.rawValue + " Storyboard")
            return T()
        }
        return nextViewController
    }
    
    //USE:- pushViewController(storyboard: .main, destinationVC: YourViewControllerName())
    func pushViewController<T: UIViewController>(storyboard: Storyboard, destinationVC: T, animated:Bool = true){
        let nextVC: T = getAnyViewController(storyboardName: storyboard)
        self.navigationController?.pushViewController(nextVC, animated: animated)
    }
   
}

