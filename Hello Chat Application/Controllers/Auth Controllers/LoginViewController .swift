//
//  LoginViewController .swift
//  Hello Chat Application
//
//  Created by Omkar Shisode on 02/10/24.
//

import SwiftUI
import FirebaseAuth

class LoginViewController: BaseViewController, SignUpDelegate {
    
    let emailAdress:UITextField = {
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
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        
        return button
    }()
    
    let signUpLabel: UILabel = {
        let signUpLabel = UILabel()
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.textAlignment = .center
        
        // create a attribute string
        let fullText:String = "Don't have account yet? Sign Up"
        let signUpText:String = "Sign Up"
        let range = (fullText as NSString).range(of: signUpText)
        
        let attributedString = NSMutableAttributedString(string:fullText)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: fullText.count))
        attributedString.addAttribute(.foregroundColor, value:UIColor.blue, range: range)
        
        signUpLabel.attributedText = attributedString
        signUpLabel.isUserInteractionEnabled = true
        return signUpLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View backgoround colour
        view.backgroundColor = .white
        // Add subviews
        view.addSubview(emailAdress)
        view.addSubview(password)
        view.addSubview(loginButton)
        view.addSubview(signUpLabel)
        
        
        // Add action to the login button
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        // SignUp button action
        let gesture = UITapGestureRecognizer(target:self, action:#selector(signUp))
        signUpLabel.addGestureRecognizer(gesture)
        // SetUp constrainlayout
        setUpConstrainLayout()
        
    }
    
    // After successful signUp back to login page and filled the email and enter passwor again
    func didCreatedUser(user: User) {
        emailAdress.text = user.email
        
    }
    
    // Sign up using the firebase
    @objc func signUp(){
        // Launch signUp controller
        let signUpViewController = SignUpViewController()
        signUpViewController.signUpDelegate = self
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    // Login user into the system
    @objc func login(){
        
        // These field are empty or not
        guard let email = emailAdress.text, !email.isEmpty,
              let password = password.text, !password.isEmpty else {
            showAlert(title: "Input Empty", message: "Please Enter credentials")
            return
        }
        
        // Show loader till you not get the callback from the firebase
        showLoader()
        
        // Login to the app via firebase authentication
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] authResult, error in
            guard let strongSelf = self else {return}
            
            // Stop loader
            strongSelf.hideLoader()
            
            // Check if error or not
            if let error = error {
                strongSelf.showAlert(title: "Login failed!!", message: error.localizedDescription)
                return
            }
            
            // If Success full logini
            UserDefaultsManager.userDefalutManager.isLoggedIn = true // set user logged to true
            let homeScreeViewController = HomeScreenController()
            if var viewController = strongSelf.navigationController?.viewControllers {
                // Remove all the activity from stack after success full login
                viewController.removeLast()
                // Append the Home screen only
                viewController.append(homeScreeViewController)
                // Set new navigation controller with new viewController value
                strongSelf.navigationController?.setViewControllers(viewController, animated: true)
            }
        }
    }
    
    
    func setUpConstrainLayout() {
        
        NSLayoutConstraint.activate([
            
            // Email text field constrain
            emailAdress.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailAdress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            emailAdress.widthAnchor.constraint(equalToConstant: 300),
            emailAdress.heightAnchor.constraint(equalToConstant: 40),
            
            // Password text field constraint
            password.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            password.topAnchor.constraint(equalTo: emailAdress.bottomAnchor, constant: 20),
            password.widthAnchor.constraint(equalToConstant: 300),
            password.heightAnchor.constraint(equalToConstant: 40),
            
            
            // Login button constraint
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 30),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            // SignUp text contraint
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signUpLabel.widthAnchor.constraint(equalToConstant: 300),
            signUpLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
        ])
    }
    
}


