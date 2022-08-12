# UserDefaultsKit

Библиотека с синтаксическим сахаром для извлечения и сохранения данных в пользовательской базе данных `UserDefaults`.

# Ипользование

Пример использования.
```swift
import Foundation
import UserDefaultsKit

extension UserDefaults.Key {
    static var isEnabledKey: UserDefaults.Key<Bool> {
        UserDefaults.Key(name: "isEnabledKey")
    }
}

// Сохранить значение.
UserDefaults[.isEnabledKey] = NEW_VALUE

// Извлечь значение.
let isEnabled = UserDefaults[.isEnabledKey]
```
