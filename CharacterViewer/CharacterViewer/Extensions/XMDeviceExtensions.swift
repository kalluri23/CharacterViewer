//
//  XMDeviceExtensions.swift
//  CharacterViewer
//
//  Created by Krishna teja Kalluri on 2/6/19.
//  Copyright © 2019 xfinity. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    class func isIphone() -> Bool {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return true
        default:
            return false
        }
    }
}
