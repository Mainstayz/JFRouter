//
//  ServiveSwift.swift
//  JFRouterDemo
//
//  Created by zz on 2019/1/4.
//  Copyright © 2019 zz. All rights reserved.
//

import UIKit

class ServiveSwift: NSObject, JFRouterMapProtocol{
    override init() {
        super.init()
        print("inittttttt")
        
    }
    @objc static func routerHandle_initialize(_ arg:Dictionary<String,Any>?) -> Any? {
        return ServiveSwift()
    }
    
    @objc static func routerHandle_foo(_ arg:Dictionary<String,Any>?) -> Any? {
        print("what the fuccccccc")
        return nil
    }
    
    
    @objc static func routerHandle_xxxx(_ arg:Dictionary<String,Any>?, callback:@escaping (Any?) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            callback("it`s ok!")
        }
    }
    
    
    @objc static func scheme() -> String {
        return "jfwallet";
    }
    @objc static func customHost() -> String {
        return "ServiveSwift"
    }
    
}

