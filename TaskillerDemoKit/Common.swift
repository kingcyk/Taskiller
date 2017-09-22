//
//  Common.swift
//  TaskillerDemo
//
//  Created by kingcyk on 11/07/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

public let AppGroupIdentifier = "group.Taskiller"
public let TaskillerDemoKitIdentifier = "com.kingcyk.TaskillerKit"

public let serverURL = "http://taskiller.kingcyk.com:9080"

public func roundAvatar(avatar: UIImageView) {
    avatar.layer.cornerRadius = avatar.frame.size.width / 2
    avatar.layer.masksToBounds = true
}

public func validateEmail(email: String) -> Bool {
    let regex = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: email)
}

public func validatePassword(password: String) -> Bool {
    let regex = "(?!^\\d+$)(?!^[a-zA-Z]+$)(?!^[_#@]+$).{8,20}"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: password)
}

public class TaskList: Object {
    public dynamic var name = ""
    public dynamic var id = 0
    public let tasks = List<Task>()
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public class Task: Object {
    public dynamic var name = ""
    public dynamic var costHour = 0
    public dynamic var costMin = 15
    public dynamic var dueTime = Date()
    public dynamic var completed = false
    public dynamic var repeatType = 0
    public dynamic var listId = 0
}
