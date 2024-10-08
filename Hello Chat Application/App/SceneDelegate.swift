//
//  SceneDelegate.swift
//  Hello Chat Application
//
//  Created by Omkar Shisode on 01/10/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else {return}
        window = UIWindow(windowScene: windowScene)
        // Check if user is already loggedIn
        if UserDefaultsManager.userDefalutManager.isLoggedIn {
            // User is  logged in navigate to the Home screen
            setUpTabBar()
        } else {
            // If user is logged out then navigate to the login view
            let loginViewController = LoginViewController()
            window?.rootViewController = UINavigationController(rootViewController: loginViewController)
        }
        window?.makeKeyAndVisible()
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
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

