//
//  Common.swift
//  TaskillerDemo
//
//  Created by kingcyk on 11/07/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import Foundation

public func roundAvatar(avatar: UIImageView) {
    avatar.layer.cornerRadius = avatar.frame.size.width / 2
    avatar.layer.masksToBounds = true
}
