//
//  UserStorage.swift
//  RozentalTest
//
//  Created by Andrei Kovryzhenko on 02.09.2024.
//

import Foundation

class UserStorage {
    
    static let shared = UserStorage()
    
    var saveData: Data? {
        get { UserDefaults.standard.data(forKey: "profile") }
        set {UserDefaults.standard.set(newValue, forKey: "profile") }
    }
}
