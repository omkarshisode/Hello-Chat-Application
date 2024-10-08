//
//  AppDelegate.swift
//  Hello Chat Application
//
//  Created by Omkar Shisode on 01/10/24.
//

import UIKit
import CoreData
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Firebase initialization
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        // Check if user is already loggedIn
        if UserDefaultsManager.userDefalutManager.isLoggedIn {
            // User is  logged in navigate to the Home screen
            setUpTabBar()
        } else {
            // If user is logged out then navigate to the login view
            let loginViewController = LoginViewController()
            window?.rootViewController = UINavigationController(rootViewController: loginViewController)
        }
        return true
    }
    
    // Set up tab bar
    func setUpTabBar() {
        
        let tabBarController = UITabBarController()
        
        let homeScreenViewContrller = HomeScreenController()
        let groupChatsViewController = GroupChatsViewController()
        let callsViewController = CallsViewController()
        let profileViewController = ProfileViewController()
        
        homeScreenViewContrller.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "bubble.left"), tag: 0)
        groupChatsViewController.tabBarItem = UITabBarItem(title: "Group", image: UIImage(systemName: "bubble.left.and.bubble.right"), tag: 1)
        callsViewController.tabBarItem = UITabBarItem(title: "Calls", image: UIImage(systemName: "phone.fill"), tag: 2)
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 3)
        
         let viewController = [
            UINavigationController(rootViewController: homeScreenViewContrller),
            UINavigationController(rootViewController: groupChatsViewController),
            UINavigationController(rootViewController: callsViewController),
            UINavigationController(rootViewController: profileViewController)
        ]
        
        tabBarController.viewControllers = viewController
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = .white // Background color
        tabBarController.tabBar.tintColor = .systemBlue // Color of the selected item
        tabBarController.tabBar.unselectedItemTintColor = .gray // Color of unselected items

        window?.rootViewController = UINavigationController(rootViewController: tabBarController)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Hello_Chat_Application")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

