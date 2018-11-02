//
//  AppDelegate.swift
//  DynamicLinkDemo
//
//  Created by Finlitetech on 02/11/18.
//  Copyright © 2018 Finlitetech. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
    
    func handleIncomingDynamicLink(_ dynamicLink: DynamicLink)
    {
        guard let url = dynamicLink.url else {
            print("dynamic link object has no url")
            return
        }
        print("dynamic link parameter is \(url.absoluteString)")
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return }
        for queryItem in queryItems
        {
            print("Parameter \(queryItem.name) has a value of \(queryItem.value ?? "")")
            let vc = ViewController()
            vc.UserID = queryItem.value!
        }
        dynamicLink.matchType
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
//        if let incomingURL = userActivity.webpageURL {
//            print("incoming url is \(incomingURL)")
//            let linkHandled = DynamicLinks.dynamicLinks().handleUniversalLink(incomingURL) { (dynamicLink, error) in
//                guard error == nil else {
//                    print("found error!\(error?.localizedDescription)")
//                    return
//                }
//                if let dynamicLink = dynamicLink {
//                    self.handleIncomingDynamicLink(dynamicLink)
//                }
//            }
//            if linkHandled
//            {
//                return true
//            }
//            else
//            {
//                return false
//            }
//        }
//        return false
        
        
        
        let handled =   DynamicLinks.dynamicLinks().handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
            
            guard error == nil else {
                print("found error!\(error?.localizedDescription)")
                return
            }
            print("Dynamic link : \(dynamiclink?.url)")
            let path = dynamiclink?.url
           
            guard let components = URLComponents(url: path!, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return }
            for queryItem in queryItems
            {
                print("Parameter \(queryItem.name) has a value of \(queryItem.value ?? "")")
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                vc.UserID = queryItem.value!
                self.window?.rootViewController = vc
            }
            
        }
        return handled
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        print("received a url through a custom scheme \(url.absoluteString)")
//        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url)
//        {
//            self.handleIncomingDynamicLink(dynamicLink)
//            return true
//        }
//        else
//        {
//            return false
//        }
        
        return application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: "")
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let dynamicLink =   DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url)
        if let dynamicLink = dynamicLink {
            print("Dynamic link : \(dynamicLink.url)")
            return true
        }
        return false
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }


}

