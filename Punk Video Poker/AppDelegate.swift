//
//  AppDelegate.swift
//  Punk Video Poker
//
//  Created by Daniel Gheorghe on 10/10/2016.
//  Copyright © 2016 The CodePunker. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        //make sure you've copied the game folder in the documents directory
        let sharedpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let gamefolder = sharedpath.path + "/videopoker";
        print("gf: " + gamefolder)
        if( FileManager.default.fileExists( atPath: gamefolder ) == false ){
            do {
                try FileManager.default.copyItem(
                    atPath: Bundle.main.url(forResource: "videopoker", withExtension:"")!.path,
                    toPath: gamefolder
                )
            } catch {
                print("Couldn't copy videopoker folder");
                print(error);
            }
        }

        //If the userData is already set (user has already seen the video) don't show the welcome video anymore
        let userDefaults = UserDefaults.standard
        let appInitializedOnce = userDefaults.bool(forKey: "appInitializedOnce");
        print(appInitializedOnce)
        if ( appInitializedOnce == true ) {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "Game")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }


}

