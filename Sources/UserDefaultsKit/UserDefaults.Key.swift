//
//  UserDefaults.Key.swift
//  UserDefaultsKit
//

import Foundation

public extension UserDefaults {
    /**
     Ключ хранения в пользовательской базе данных.
     */
    struct Key<Value> {
        /**
         Имя ключа.
         */
        public let name: String
        /**
         Значение ключа по умолчанию.
         */
        public let defaultValue: Value
        
        /**
         Создать ключа хранения в пользовательской базе данных.
         - Parameter name: Имя ключа.
         - Parameter defaultValue: Значение ключа по умолчанию.
         */
        public init(name: String, defaultValue: Value) {
            self.name = name
            self.defaultValue = defaultValue
        }
        
        
    }
    
    
}
