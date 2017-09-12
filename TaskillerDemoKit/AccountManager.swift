//
//  AccountManager.swift
//  TaskillerDemo
//
//  Created by kingcyk on 08/09/2017.
//  Copyright © 2017 kingcyk. All rights reserved.
//

import Foundation
import KeychainAccess

public class AccountManager: NSObject {
    
    private override init() {
        super.init()
        
        if currentAccount == nil && !taskillerKeychain.allKeys().isEmpty {
            try! taskillerKeychain.removeAll()
        }
    }
    
    public static let sharedInstance = AccountManager()
    
    let groupDefaults = UserDefaults(suiteName: AppGroupIdentifier)!
    
    private let taskillerKeychain = Keychain(server: "http://taskiller.kingcyk.com", protocolType: .http)
    private let CurrentAccountKey = "CurrentAccountKey"
    
    public func addAccount(_ username: String, _ password: String) {
        taskillerKeychain[username] = password
        currentAccount = username
    }
    
    public var currentAccount: String? {
        get {
            return groupDefaults.string(forKey: CurrentAccountKey)
        }
        set {
            groupDefaults.set(newValue, forKey: CurrentAccountKey)
            groupDefaults.synchronize()
        }
    }

}
