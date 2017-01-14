//
//  YHJSONGenerator+URL.swift
//  Swift3Project
//
//  Created by Yilei He on 14/1/17.
//  Copyright © 2017 lionhylra.com. All rights reserved.
//

import Foundation

extension URL: JSONConvertible {
    public func toJSON() -> JSONCompatible {
        return absoluteString
    }
}
