//
//  CodableUserDefault.swift
//  UserDefaultsKit
//

import Foundation

/**
 Обертка свойств для использования UserDefaults.
 
 Источник: [Projecting a Value From a Property Wrapper](https://www.avanderlee.com/swift/property-wrappers/#projecting-a-value-from-a-property-wrapper).
 
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
