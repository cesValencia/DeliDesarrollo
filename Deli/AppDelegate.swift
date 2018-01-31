//
//  AppDelegate.swift
//  Deli
//
//  Created by David Valencia on 05/01/18.
//  Copyright © 2018 AMG Arts. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Getting API Key
        GMSServices.provideAPIKey("AIzaSyB64NblnsoVjdvz9xvJsDKnfbQQsHGBHsA")
        
        // Configuración del SDK de Facebook
//        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        let userDefaults = UserDefaults.standard
        let result = userDefaults.bool(forKey: kIsFirstEntry)
        var nav: UIViewController?
        
        if result == false {
            //Creamos una pantalla para iniciar la app
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let cards = storyBoard.instantiateViewController(withIdentifier: "MainCards")
            
            //Seteamos la key y sincronizamos para guardar la información
            userDefaults.set(true, forKey: kIsFirstEntry)
            userDefaults.synchronize()
            
            //Creamos navigationController y le pasamos la pantalla intro como rootViewController
            nav = cards
            
        } else {
            // Creamos una instancia de la primera pantalla
            let start = Intro()
            start.view.backgroundColor = UIColor.white
            nav = start
        }
        
        
        // Inicializamos la instancia de tipo intro como el controlador raíz
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }
    
//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
//    }

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
