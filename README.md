# UserDefaultsKit

Библиотека с синтаксическим сахаром для извлечения и сохранения данных в пользовательской базе данных `UserDefaults`.

# Ипользование

Пример использования.
```swift
import Foundation
import UserDefaultsKit

extension UserDefaults {
    @UserDefault(key: "isAppAlreadyLaunchedOnceKey", defaultValue: false)
    static var isAppAlreadyLaunchedOnce: Bool
}
```
