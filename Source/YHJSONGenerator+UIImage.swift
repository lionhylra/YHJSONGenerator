//
//  YHJSONGenerator+UIImage.swift
//  Swift3Project
//
//  Created by Yilei He on 14/1/17.
//  Copyright © 2017 lionhylra.com. All rights reserved.
//

import UIKit

extension UIImage: JSONConvertible {
    public func toJSON() -> JSONCompatible {
        return UIImagePNGRepresentation(self)?.base64EncodedString() ?? ""
    }
}
