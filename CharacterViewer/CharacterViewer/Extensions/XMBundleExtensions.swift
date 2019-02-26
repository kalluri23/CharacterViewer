//
//  XMBundleExtensions.swift
//  CharacterViewer
//
//  Created by Krishna teja Kalluri on 2/5/19.
//  Copyright © 2019 xfinity. All rights reserved.
//

import Foundation

extension Bundle {//Get app display name from info.plist
    class func getAppName() -> String {
        if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return appName
        }else {
            assertionFailure("Please set the name of the app")
            return ""
        }
    }
    
    
}
