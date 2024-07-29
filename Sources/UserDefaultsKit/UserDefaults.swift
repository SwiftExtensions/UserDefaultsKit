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

extension UserDefaults {
    func decodableObject<T>(forKey: String) -> T? where T: Decodable {
        let data = self.object(forKey: forKey) as? Data
        return data.flatMap {
            try? JSONDecoder().decode(T.self, from: $0)
        }
    }
    
    func setEncodable<T>(_ value: T, forKey: String) where T: Encodable {
        if let encoded = try? JSONEncoder().encode(value) {
            self.set(encoded, forKey: forKey)
        }
    }
        
}
