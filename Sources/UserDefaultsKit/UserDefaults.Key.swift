//
//  UserDefaults.Key.swift
//  UserDefaultsKit
//
//  Created by Лайм HD on 12.08.2022.
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
         Создать ключа хранения в пользовательской базе данных.
         */
        public init(name: String) {
            self.name = name
        }
        
        
    }
    
    
}
