//
//  AppDelegate.swift
//  Movie Feed
//
//  Created by DANCECOMMANDER on 20.09.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let networkManager = MovieNetworkManager()
        let alertPresenter = AlertPresenter(viewController: nil)
        let feedPresenter = FeedPresenter(networkManager: networkManager, alertPresenter: alertPresenter)
        
        let feedViewController = FeedViewController(presenter: feedPresenter, networkManager: networkManager)
        alertPresenter.viewController = feedViewController
        
        feedPresenter.view = feedViewController
        
        window?.rootViewController = UINavigationController(rootViewController: feedViewController)
        window?.makeKeyAndVisible()
        
        return true
    }
}




