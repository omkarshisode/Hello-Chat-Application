//
//  UserDefalutManager .swift
//  Hello Chat Application
//
//  Created by Omkar Shisode on 06/10/24.
//

import Foundation

class UserDefaultsManager {
    
    // Static instance of the UserDefalut
    static let userDefalutManager = UserDefaultsManager()
    
    // Make constructor to private
    private init() {}
    
    // enum of the value that going to store into the defaults
    
    enum UserDefaultsKey: String {
        case isLoggedIn
        case appTheme
    }
    
    // getter setter for isLoggedIn from userDefaults
    var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.isLoggedIn.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKey.isLoggedIn.rawValue)
        }
    }
    
    // getter setter for app theme from userDefaluts
    var appTheme:String? {
        get {
            return UserDefaults.standard.string(forKey: UserDefaultsKey.appTheme.rawValue)
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKey.appTheme.rawValue)
        }
    }
    
    // To clear all the userDefault
    func clearAllUserDefaults() {
       if let appDomain = Bundle.main.bundleIdentifier {
           UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
        
        // Synchronize the userDefaults if any value is writing to the user default
        UserDefaults.standard.synchronize()
    }
    
}
