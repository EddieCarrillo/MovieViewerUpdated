//
//  AppDelegate.swift
//  MovieViewer
//
//  Created by my mac on 2/1/17.
//  Copyright © 2017 Eduardo Carrillo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let primaryColor = UIColor.black
        let secondaryColor = UIColor(red: 255/255.0, green: 215.0/255, blue: 0/255, alpha: 1.0)
        
       window = UIWindow(frame: UIScreen.main.bounds)
    
      let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        //Now Playing Navigation Controller
       let nowPlayingNavController = storyBoard.instantiateViewController(withIdentifier: "MovieNavigationController") as! UINavigationController
        nowPlayingNavController.tabBarItem.title = "Now Playing"
        
        nowPlayingNavController.navigationBar.barTintColor = UIColor.black
        nowPlayingNavController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: secondaryColor]
        nowPlayingNavController.navigationItem.title = "Now Playing"
        
        
        nowPlayingNavController.navigationBar.tintColor = secondaryColor
        
        
        nowPlayingNavController.tabBarItem.title = "Now Playing"
           nowPlayingNavController.tabBarItem.image = UIImage(named: "now_playing")
        
        
     //Now Playing view controller
       let nowPlayingViewController = nowPlayingNavController.topViewController as! MoviesViewController
        nowPlayingViewController.title = "Now Playing"
        nowPlayingViewController.endpoint = "now_playing"
     
       
        
        //Top rated navigation controller
        let topRatedNavController = storyBoard.instantiateViewController(withIdentifier: "MovieNavigationController") as! UINavigationController
        
        topRatedNavController.navigationItem.title = "Now Playing"
         topRatedNavController.navigationBar.tintColor = secondaryColor
        topRatedNavController.navigationBar.barTintColor = UIColor.black
        topRatedNavController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: secondaryColor]
        topRatedNavController.tabBarItem.title = "Top Rated"
        topRatedNavController.tabBarItem.image = UIImage(named: "top_rated")
        
        
        //Top rated view controler
        let topRatedViewController = topRatedNavController.topViewController as! MoviesViewController
        topRatedViewController.title = "Top Rated"
        topRatedViewController.endpoint = "top_rated"
        
        
        

        
        
        
        let tabBarController = UITabBarController()
        
    
        
        tabBarController.tabBar.barTintColor = primaryColor
        tabBarController.tabBar.tintColor = secondaryColor
        
        tabBarController.viewControllers = [nowPlayingNavController, topRatedNavController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        
        // Override point for customization after application launch.
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

