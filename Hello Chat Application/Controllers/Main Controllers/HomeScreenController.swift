//
//  HomeScreenController.swift
//  Hello Chat Application
//
//  Created by Omkar Shisode on 02/10/24.
//

import SwiftUI

class HomeScreenController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Add table view to Home Screen
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(UserInfoCell.self, forCellReuseIdentifier: UserInfoCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // User info list 
    var userInfos:[UserInfo] = []
    
    // Prepare user info
    func preapareUserInfo(){
        for i in 1...30 {
            let userInfo = UserInfo(name: "User Name \(i)", profileImage: UIImage(named: "sunset"), lastMessage: "Hello User", lastMessageTime: "12/12/23", newMessageCount: 12)
            userInfos.append(userInfo)
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Preapare user info
        preapareUserInfo()
        
        // Add the background color to the home screen view controller
        view.backgroundColor = .white
        // Action bar title
        setUpActionBar()
        // Set up constraint of all child view inside of home screen
        setUpTableView()
        setUpConstraintLayout()
    }
    
    func setUpTableView() {
        // Add table view to Home screen view controller
        self.view.addSubview(tableView)
        // Confirm the tableView delegate and data source delegate
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Set the row height
        self.tableView.rowHeight = 80 // Adjust this value as needed
    }
    
    // Implement the table view property
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Check if UserInfoCell is dequeueReusableOrNot
        guard let userInfoCell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.identifier, for: indexPath) as? UserInfoCell else {
            fatalError("The TableView could not dequeue a UserInfo Cell in HomeScreenViewController")
        }
        
        // Set properties of the UserInfo cell
        let userInfo = userInfos[indexPath.row]
        userInfoCell.configure(with: userInfo)
        
        return userInfoCell
    }
    
    func setUpConstraintLayout() {
        NSLayoutConstraint.activate([
            // Table view constraint
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor), // Below navigation bar
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func setUpActionBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Hello"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        self.navigationItem.titleView = titleLabel
    }
    
}
