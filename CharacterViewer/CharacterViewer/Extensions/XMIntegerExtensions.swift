//
//  XMIntegerExtensions.swift
//  CharacterViewer
//
//  Created by Krishna teja Kalluri on 2/5/19.
//  Copyright © 2019 xfinity. All rights reserved.
//

import Foundation

extension UInt64 {
    
    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }
    
}
