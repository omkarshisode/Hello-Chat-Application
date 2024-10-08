//
//  UserInfoCell.swift
//  Hello Chat Application
//
//  Created by Omkar Shisode on 08/10/24.
//

import UIKit

class UserInfoCell: UITableViewCell {
    // Cell identifier to connect with table view
    static let identifier = "UserInfoCell"
    
    // Profile image view
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25 // half of the width/height to make it circular
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // User name label
    let name: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    // User last name label
    let lastSeen: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 11, weight: .light)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    // Last seen label
    let lastMessage:UILabel = {
        let lsLabel = UILabel()
        lsLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        lsLabel.translatesAutoresizingMaskIntoConstraints = false
        return lsLabel
    }()
    
    // New message count
    let newMessageCount:UILabel = {
        let count = UILabel()
        count.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        count.textColor = .black
        count.translatesAutoresizingMaskIntoConstraints = false
        count.textAlignment = .center
        count.layer.cornerRadius = 10
        count.clipsToBounds = true
        count.isHidden = true
        count.backgroundColor = .green
        return count
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set up the view and constraints
    func setUpView() {
        contentView.addSubview(profileImage)
        contentView.addSubview(name)
        contentView.addSubview(lastSeen)
        contentView.addSubview(lastMessage)
        contentView.addSubview(newMessageCount)
        
        // Set up constraints for profile image and user name
        NSLayoutConstraint.activate([
            
            // Profile image constraints
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            
            // User name label constraints
            name.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 30),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: lastSeen.leadingAnchor, constant: -5),
            
            // User Last name constraint
            lastSeen.leadingAnchor.constraint(equalTo: name.trailingAnchor),
            lastSeen.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            lastSeen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:-16),
            
            // User last message
            lastMessage.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            lastMessage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            lastMessage.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 30),
            
            // New Messages Count Label Constraints
            newMessageCount.topAnchor.constraint(equalTo: lastSeen.bottomAnchor, constant: 8),
            newMessageCount.leadingAnchor.constraint(equalTo: lastSeen.leadingAnchor, constant: 10),
            newMessageCount.widthAnchor.constraint(equalToConstant: 20),
            newMessageCount.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
    // Configure the cell properties
    func configure(with userInfo:UserInfo){
        
        profileImage.image = userInfo.profileImage
        name.text = userInfo.name
        lastMessage.text = userInfo.lastMessage
        lastSeen.text = userInfo.lastMessageTime
        
        if(userInfo.newMessageCount > 0){
            newMessageCount.text = "\(userInfo.newMessageCount)"
            newMessageCount.isHidden = false
            newMessageCount.backgroundColor = .green
        } else {
            newMessageCount.isHidden = true
        }
        
    }
}
