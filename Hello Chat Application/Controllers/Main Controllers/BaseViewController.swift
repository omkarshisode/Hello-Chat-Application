//
//  ViewController.swift
//  Hello Chat Application
//
//  Created by Omkar Shisode on 01/10/24.
//

import UIKit

class BaseViewController : UIViewController {
    
    let activitIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add loader to view
        view.addSubview(activitIndicator)
        
        // Setup the layout constain for the sub view
        setLayoutConstrain()
    }
    
    // Show loader on the view and disable user interaction
    func showLoader(){
        activitIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    // Stop the loader and enable the userInteraction
    func hideLoader(){
        activitIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    // Layout constrain of the view
    func setLayoutConstrain() {
        NSLayoutConstraint.activate([
            activitIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activitIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

