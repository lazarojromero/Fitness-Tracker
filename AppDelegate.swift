//
//  AppDelegate.swift
//  NoleFit
//
//  Created by Lazaro Romero on 3/31/16.
//  Copyright © 2016 Lazaro Romero. All rights reserved.
//

import UIKit
import CoreLocation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var locationManager: CLLocationManager?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UINavigationBar.appearance().barStyle = .Black
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()//obtaining location information permission
        return true
    }
    func applicationWillResignActive(application: UIApplication) {

    }
    func applicationDidEnterBackground(application: UIApplication) {

    }
    func applicationWillEnterForeground(application: UIApplication) {

    }
    func applicationDidBecomeActive(application: UIApplication) {

    }
    func applicationWillTerminate(application: UIApplication) {

    }
}

