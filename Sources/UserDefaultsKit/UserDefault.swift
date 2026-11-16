//
//  UserDefault.swift
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
 
 - Warning: `Value` должен быть property-list типом (`String`, `Bool`,
   числовые типы, `Date`, `Data`, массивы и словари из них). Для остальных
   типов используйте `CodableUserDefault`, иначе сохранение завершится
   с исключением `NSInvalidArgumentException`.
 
 - Note: Одному имени ключа должен соответствовать один тип значения.
   `Bool` и числовые типы хранятся как `NSNumber`, поэтому чтение того же
   ключа с другим числовым типом вернет сконвертированное значение
   (например, `Bool` читается как `Int` = 1), а не `defaultValue`.
 */
@propertyWrapper
public struct UserDefault<Value> {
    /**
     Ключ хранения в пользовательской базе данных.
     */
    public let key: UserDefaults.Key
    /**
     Значение по умолчанию для ключа.
     */
    public let defaultValue: Value
    /**
     Контейнер хранения.
     */
    public let container: UserDefaults

    /**
     Обертка для значения.
     */
    public var wrappedValue: Value {
        get {
            self.container.object(forKey: self.key.rawValue) as? Value ?? self.defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                self.container.removeObject(forKey: self.key.rawValue)
            } else {
                self.container.set(newValue, forKey: self.key.rawValue)
            }
        }
    }
    
    /**
     Создает новую обертку для свойства с указанным ключом.
     - Parameter key: Ключ для хранения в пользовательной базе данных.
     - Parameter defaultValue: Значение по умолчанию для ключа.
     - Parameter container: Контейнер хранения.
     */
    public init(key: UserDefaults.Key, defaultValue: Value, container: UserDefaults = .standard) {
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
     - Parameter container: Контейнер хранения.
     */
    init(key: UserDefaults.Key, container: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, container: container)
    }
    
    
}

// MARK: - AnyOptional

protocol AnyOptional {
    /**
     Возвращает `true` если `nil`, в противном случае `false`.
     */
    var isNil: Bool { get }
    
    
}

extension Optional: AnyOptional {
    /**
     Возвращает `true` если `nil`, в противном случае `false`.
     */
    var isNil: Bool { self == nil }
    
    
}
