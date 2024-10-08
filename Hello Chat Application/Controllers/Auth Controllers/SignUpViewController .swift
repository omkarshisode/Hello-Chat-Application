//
//  SingUpViewController .swift
//  Hello Chat Application
//
//  Created by Omkar Shisode on 04/10/24.
//

import SwiftUI
import FirebaseAuth

class SignUpViewController : BaseViewController {
    
    weak var signUpDelegate:SignUpDelegate?
    
    let firstName:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your first name"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        
        return textField
    }()
    
    let lastName:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your last name"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        
        return textField
    }()
    
    let email:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        
        return textField
    }()
    
    let password:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter you password"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 8
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Add first name
        view.addSubview(firstName)
        view.addSubview(lastName)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(signUpButton)
        
        // Sign Up button action
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        setUpLayoutContraint()
    }
    
    
    @objc func signUp(){
        
        // Check all the field all filled or not
        guard let firstNameText = firstName.text, !firstNameText.isEmpty,
              let lastNameText = lastName.text, !lastNameText.isEmpty,
              let emailText = email.text, !emailText.isEmpty,
              let passwordText = password.text, !passwordText.isEmpty else {
            showAlert(title: "Warning!!", message: "Please Enter all field!!")
            return
        }
        
        // Enable loader
        showLoader()
        // Create new user on firebase with email and password
        Auth.auth().createUser(withEmail:emailText , password: passwordText) {
            authResult, error in
            
            // Stop loader
            self.hideLoader()
            // On user creation failed show pop up with message
            if let error = error {
                self.showAlert(title: "Failed",
                        message: "Failed to create User: \(error.localizedDescription)")
                return
            }
            

            // On successful login create a user object
            let user = User()
            user.firstName = firstNameText
            user.lastName = lastNameText
            user.email = emailText
            user.isOnline = true
            user.isLoggedIn = true
            user.profileImageURL = " "
            
            // Send user data via delegate to another controller
            self.signUpDelegate?.didCreatedUser(user: user)
            // If successFully created dismiss the sign Up view controller
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
    func setUpLayoutContraint(){
        NSLayoutConstraint.activate([
            // First name constaint
            firstName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            firstName.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            firstName.widthAnchor.constraint(equalToConstant: 300),
            firstName.heightAnchor.constraint(equalToConstant: 40),
            
            // Last name constaint
            lastName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastName.topAnchor.constraint(equalTo: firstName.topAnchor, constant: 60),
            lastName.widthAnchor.constraint(equalToConstant: 300),
            lastName.heightAnchor.constraint(equalToConstant: 40),
            
            // Email constaint
            email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            email.topAnchor.constraint(equalTo: lastName.topAnchor, constant: 60),
            email.widthAnchor.constraint(equalToConstant: 300),
            email.heightAnchor.constraint(equalToConstant: 40),
            
            // Password constaint
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.topAnchor.constraint(equalTo: email.topAnchor,constant: 60),
            password.widthAnchor.constraint(equalToConstant: 300),
            password.heightAnchor.constraint(equalToConstant: 40),
            
            // SignUp button constaint
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: password.topAnchor, constant: 70),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signUpButton.widthAnchor.constraint(equalToConstant: 200),
            
            
        ])
    }
}

