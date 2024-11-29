//
//  AppDelegate.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Override point for customization after application launch.

      // This is to show the User Defaults location in the device.
      // print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)

      // 261. Location of the Realm file
      print(Realm.Configuration.defaultConfiguration.fileURL!)

      // Initialize Realm
      do {
        // Making it underscore and removing the let keyword
        // since is not being used anywhere 
        _ = try Realm()
      } catch {
        print("Error initializing Realm: \(error)")
      }

      return true
    }
}

