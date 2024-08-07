//
//  CodableUserDefault.swift
//  UserDefaultsKit
//

import Foundation

/**
 Обертка свойств для использования
 [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults).
 
 Пример использования:
 ``` swift
 import Foundation
 import UserDefaultsKit
 
 struct Person {
   let name: String
 }
 
 extension UserDefaults {
     @CodableUserDefault(key: "personKey", defaultValue: Person(name: "Alex"))
     static var person: Person
 }
 ```
 */
@propertyWrapper
public struct CodableUserDefault<Value: Codable> {
    /**
     Ключ хранения в пользовательской базе данных.
     */
    public let key: String
    /**
     Значение по умолчанию для ключа.
     */
    public let defaultValue: Value
    /**
     Контейнер хранения.
     */
    public var container: UserDefaults = .standard

    /**
     Обертка для значения.
     */
    public var wrappedValue: Value {
        get {
            self.container.decodableObject(forKey: self.key) ?? self.defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                self.container.removeObject(forKey: self.key)
            } else {
                self.container.setEncodable(newValue, forKey: self.key)
            }
        }
    }
    
    /**
     Создает новую обертку для свойства с указанным ключом.
     - Parameter key: Ключ для хранения в пользовательной базе данных.
     - Parameter defaultValue: Значение по умолчанию для ключа.
     - Parameter container: Контейнер хранения.
     */
    public init(key: String, defaultValue: Value, container: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.container = container
    }
    
    
}

// MARK: - ExpressibleByNilLiteral

public extension CodableUserDefault where Value: ExpressibleByNilLiteral {
    /**
     Создает новую обертку для свойства с указанным ключом.
     - Parameter key: Ключ для хранения в пользовательной базе данных.
     - Parameter container: Контейнер хранения.
     */
    init(key: String, _ container: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, container: container)
    }
    
    
}
