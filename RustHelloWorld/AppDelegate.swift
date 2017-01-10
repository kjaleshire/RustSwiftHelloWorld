//
//  AppDelegate.swift
//  RustHelloWorld
//
//  Created by Kyle J Aleshire on 2/12/16.
//  Copyright © 2016 Kyle J Aleshire. All rights reserved.
//

import UIKit

extension RustByteSlice {
    func asUnsafeBufferPointer() -> UnsafeBufferPointer<UInt8> {
        return UnsafeBufferPointer(start: bytes, count: len)
    }
    
    func asString(_ encoding: String.Encoding = String.Encoding.utf8) -> String? {
        return String(bytes: asUnsafeBufferPointer(), encoding: encoding)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let result = rust_hello_world()

        print("I called rust and got \(result)")
        
        exercisePrimitives()
        
        let myString = "Hello from Swift!"
        
        let data = myString.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        utf8_bytes_to_rust((data as NSData).bytes.bindMemory(to: Int8.self, capacity: data.count), data.count)
        
        let myString2 = "Second hello from Swift!"
        
        c_string_to_rust(myString2)
        
        let rustString = get_string_from_rust()
        
        if let stringFromRust = rustString.asString() {
            print("got a string from Rust: \(stringFromRust)")
        } else {
            print("Could not parse the Rust string as utf-8")
        }
        
        return true
    }
    
    func exercisePrimitives() {
        let a: Int32 = rust_hello_world()
        let b: UInt16 = triple_a_uint16(10)
        let c: Float = return_float()
        let d: Double = average_two_doubles(10, 20)
        let e: Int = sum_sizes(20, 30)
        print("primitives: \(a) \(b) \(c) \(d) \(e)")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

