//
//  SceneDelegate.swift
//  Guardian
//
//  Created by Zulfa Aliyah on 05/01/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let launchedBefore = UserDefaults.standard.bool(forKey: "hasLaunched")
        let launchStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let NasabahMainStoryboard = UIStoryboard(name: "NasabahMain", bundle: nil)
        let AdminMainStoryboard = UIStoryboard(name: "AdminMain", bundle: nil)
        
        var vc = UIViewController()
            if launchedBefore {
                API().checkToken()
                let level = UserDefaults.standard.integer(forKey: "userLevel")
                if level == 0 {
                    vc = AdminMainStoryboard.instantiateInitialViewController()!
                } else if level == 1 {
                    vc = NasabahMainStoryboard.instantiateInitialViewController()!
                }
            } else {
                vc = launchStoryboard.instantiateViewController(identifier: "Onboarding")
            }
        UserDefaults.standard.set(true, forKey: "hasLaunched")
        self.window?.rootViewController = vc
    }

    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        // change the root view controller to your specific view controller
        window.rootViewController = vc
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

