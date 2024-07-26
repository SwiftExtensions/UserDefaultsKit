//
//  UserDefaults.swift
//  UserDefaultsKit
//

import Foundation

/**
 Обертка свойств для использования
 [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults).
 
 Источник: [Projecting a Value From a Property Wrapper](https://www.avanderlee.com/swift/property-wrappers/#projecting-a-value-from-a-property-wrapper).
 
 Пример использования:
 ``` swift
 import Foundation
 import UserDefaultsKit
 
 extension UserDefaults {
     @UserDefault(key: "isAppAlreadyLaunchedOnceKey", defaultValue: false)
     static var isAppAlreadyLaunchedOnce: Bool
 }
 ```
 */
@propertyWrapper
public struct UserDefault<Value> {
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
            self.container.object(forKey: self.key) as? Value ?? self.defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                self.container.removeObject(forKey: self.key)
            } else {
                self.container.set(newValue, forKey: self.key)
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

public extension UserDefault where Value: ExpressibleByNilLiteral {
    /**
     Создает новую обертку для свойства с указанным ключом.
     - Parameter key: Ключ для хранения в пользовательной базе данных.
     - Parameter container: Контейнер хранения.
     */
    init(key: String, _ container: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, container: container)
    }
    
    
}

// MARK: - AnyOptional

public protocol AnyOptional {
    /**
     Возвращает `true` если `nil`, в противном случае `false`.
     */
    var isNil: Bool { get }
    
    
}

extension Optional: AnyOptional {
    /**
     Возвращает `true` если `nil`, в противном случае `false`.
     */
    public var isNil: Bool { self == nil }
    
    
}
