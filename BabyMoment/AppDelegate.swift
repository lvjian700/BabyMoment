//
//  AppDelegate.swift
//  BabyMoment
//
//  Created by Xueliang Zhu on 8/24/16.
//  Copyright © 2016 kotlinchina. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        IQKeyboardManager.sharedManager().enable = true
        return true
    }
}

