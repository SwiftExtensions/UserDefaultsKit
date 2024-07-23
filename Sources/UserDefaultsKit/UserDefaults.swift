//
//  UserDefaults.swift
//  UserDefaultsKit
//

import Foundation

public extension UserDefaults {
    subscript<Object>(key: Key<Object>) -> Object? {
        get { self.object(forKey: key.name) as? Object }
        set { self.set(newValue, forKey: key.name) }
    }
    
    static subscript<Object>(key: Key<Object>) -> Object? {
        get { UserDefaults.standard[key] }
        set { UserDefaults.standard[key] = newValue }
    }
    
    static func getObjectOrDefault<Object>(for key: Key<Object>) -> Object {
        UserDefaults[key] ?? key.defaultValue
    }
    
    
}
