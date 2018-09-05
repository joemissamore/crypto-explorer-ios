//
//  AppDelegate.swift
//  CryptoCurrencyFeed
//
//  Created by Joseph Missamore on 8/23/18.
//  Copyright © 2018 Joseph Missamore. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        
        
        /// Instantiate View Controllers
        let flowLayout = UICollectionViewFlowLayout()
        let cryptoFeedController = ViewController(collectionViewLayout: flowLayout)
        cryptoFeedController.title = "Crypto Live Feed"
        
        let exchangeController = ExchangeController()
        exchangeController.title = "Exchanges"
        /// ----------------
        
        
        /// TabBarControllers
        let tabBarController = UITabBarController()
        cryptoFeedController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        exchangeController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        /// ----------------
        
        /// Controllers
        let controllers = [cryptoFeedController, exchangeController]
        /// ----------------
        
        /// Map tabBarControllers views
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        /// ----------------
        
        /// Set initial view on the tabBarController
        tabBarController.selectedIndex = 1
        /// ----------------
        
        /// Set UIViewControllers navigation bar style
        controllers.forEach {
            $0.navigationController?.navigationBar.barStyle = .black
        }
        /// ----------------
        
        /// Set tabBarController bar style
        tabBarController.tabBar.barStyle = .black
        /// ----------------
    
        
        
//        let rootNavigationController = UINavigationController(rootViewController: cryptoFeedController)
        
//        DEFAULT
        window?.rootViewController = tabBarController
        
        // DEVELOPMENT
//        UserDefaults.standard.set([ExchangeAssetsUserDefault](), forKey: "selectedCurrency")
//        window?.rootViewController = ExchangeAssetsController()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

