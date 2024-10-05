//
//  Extenstions.swift
//  Hello Chat Application
//
//  Created by Omkar Shisode on 02/10/24.
//

import Foundation
import UIKit

extension UIViewController {
    // Extenstion function that accessible into the UIViewController 
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
