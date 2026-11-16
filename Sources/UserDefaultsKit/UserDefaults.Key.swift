//
//  UserDefaults.Key.swift
//  UserDefaultsKit
//

import Foundation

public extension UserDefaults {
    /**
     Ключ хранения в пользовательской базе данных.
     */
    struct Key: RawRepresentable, Hashable {
        /**
         Имя ключа.
         */
        public let rawValue: String
        
        /**
         Создает ключ хранения в пользовательской базе данных.
         - Parameter rawValue: Имя ключа.
         */
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        
    }
    
    
}

// MARK: - ExpressibleByStringLiteral

extension UserDefaults.Key: ExpressibleByStringLiteral {
    /**
     Создает ключ хранения из строкового литерала.
     - Parameter value: Имя ключа.
     */
    public init(stringLiteral value: String) {
        self.init(rawValue: value)
    }
    
    
}
