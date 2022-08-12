//
//  UserDefaults.swift
//  UserDefaultsKit
//
//  Created by Лайм HD on 12.08.2022.
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
    
    
}
