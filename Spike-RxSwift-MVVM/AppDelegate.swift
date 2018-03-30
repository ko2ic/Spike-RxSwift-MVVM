//
//  AppDelegate.swift
//  Spike-RxSwift-MVVM
//
//  Created by 石井幸次 on 2018/03/26.
//  Copyright © 2018年 ko2ic. All rights reserved.
//

import Domains
import Infrastructures
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        LoggerInitializer.sharedInstance.setup()
        LocatorInitializer.sharedInstance.setup()

        Migration.migration()

        return true
    }

    func applicationWillResignActive(_: UIApplication) {
    }

    func applicationDidEnterBackground(_: UIApplication) {
    }

    func applicationWillEnterForeground(_: UIApplication) {
    }

    func applicationDidBecomeActive(_: UIApplication) {
    }

    func applicationWillTerminate(_: UIApplication) {
    }
}
