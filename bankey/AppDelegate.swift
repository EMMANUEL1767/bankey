//
//  AppDelegate.swift
//  bankey
//
//  Created by Emmanuel Biju on 27/11/24.
//

import UIKit

let appColor = UIColor.systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onboardingViewController = OnboardingContainerViewController()
    let homeViewController = HomeViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        onboardingViewController.delegate = self
        window?.rootViewController = homeViewController
        
        return true
    }
}

extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootViewController(homeViewController, animated: true)
        } else {
            setRootViewController(onboardingViewController, animated: true)
        }
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didCompleteOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(homeViewController, animated: true)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController, animated: true)
    }
}

extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = false) {
        guard animated, let window = self.window else {
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
