# UserDefaultsKit

Библиотека с синтаксическим сахаром для извлечения и сохранения данных в пользовательской базе данных `UserDefaults`.

## Использование

### Property-list типы

Для `String`, `Bool`, числовых типов, `Date`, `Data` и коллекций из них:
```swift
import Foundation
import UserDefaultsKit

extension UserDefaults {
    @UserDefault(key: "isAppAlreadyLaunchedOnceKey", defaultValue: false)
    static var isAppAlreadyLaunchedOnce: Bool
}
```

### Codable-типы

Для произвольных `Codable`-типов:
```swift
import Foundation
import UserDefaultsKit

struct Person: Codable {
    let name: String
}

extension UserDefaults {
    @CodableUserDefault(key: "personKey", defaultValue: Person(name: "Alex"))
    static var person: Person
}
```

Запись `nil` в опциональное свойство удаляет значение из хранилища.

### Именованные ключи

Ключи можно выносить в `UserDefaults.Key` и переиспользовать:
```swift
extension UserDefaults.Key {
    static let person: Self = "personKey"
}

extension UserDefaults {
    @CodableUserDefault(key: .person, defaultValue: Person(name: "Alex"))
    static var person: Person
}
```
