//
//  Utilities.swift
//  Lifesum
//
//  Created by Alexandru Savu on 1/24/16.
//  Copyright © 2016 alexsavu. All rights reserved.
//

import Foundation

extension NSURL {
    
    static func temporaryURL() -> NSURL {
        return try! NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.CachesDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true).URLByAppendingPathComponent(NSUUID().UUIDString)
    }
    
    static var documentsURL: NSURL {
        return try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
    }
}

extension String {
    public var normalizedForSearch: String {
        let transformed = stringByApplyingTransform("Any-Latin; Latin-ASCII; Lower", reverse: false)
        return transformed as String? ?? ""
    }
}