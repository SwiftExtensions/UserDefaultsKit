# История изменений

Все значимые изменения в проекте документируются в этом файле.

Формат основан на [Keep a Changelog](https://keepachangelog.com/ru/1.1.0/),
проект придерживается [семантического версионирования](https://semver.org/lang/ru/).

## [Unreleased]

## [1.0.0] - 2026-11-16

### Добавлено

- `UserDefaults.Key` — типизированный ключ хранения (`RawRepresentable`, `Hashable`, `ExpressibleByStringLiteral`); ключи можно выносить в именованные константы и переиспользовать.
- `LICENSE` (MIT).
- Платформы в `Package.swift`: iOS 13, macOS 10.15, tvOS 13, watchOS 6.
- `init(key:container:)` для `CodableUserDefault` с опциональными значениями.
- Тесты для `UserDefault` и `CodableUserDefault`.
- Описание `CodableUserDefault` и именованных ключей в README.

### Изменено

- **Ломающее изменение:** generic `UserDefaults.Key<Value>` заменен на простой `UserDefaults.Key`; значение по умолчанию больше не хранится в ключе.
- Параметр `key` в `UserDefault` и `CodableUserDefault` теперь имеет тип `UserDefaults.Key` вместо `String`; строковые литералы продолжают работать без изменений.
- `container` в обеих обертках — `let` вместо `var`.
- `init(key:_:)` переименован в `init(key:container:)` — параметр контейнера получил метку.
- `AnyOptional` убран из публичного API (стал внутренним протоколом).
- `CodableUserDefault` сохраняет property-list типы (`String`, `Bool`, числа, `Date`, `Data`, коллекции из них) нативно; JSON используется только для остальных типов. Ранее сохраненные JSON-значения остаются читаемыми.
- Ошибки кодирования в `CodableUserDefault` выводятся через `assertionFailure` в отладочных сборках вместо тихого игнорирования.
- `JSONEncoder`/`JSONDecoder` создаются один раз, а не на каждое обращение.

### Удалено

- Subscript'ы `defaults[key]` и `UserDefaults[key]`, а также `getObjectOrDefault(for:)`.
- `defaultValue` у `UserDefaults.Key`.

### Исправлено

- Исключение `NSInvalidArgumentException` при записи `nil` через subscript (устранено вместе с API).
- Пример в документации `CodableUserDefault` не компилировался: `Person` теперь `Codable`.
- Опечатки в документации и неверное имя файла в заголовке `UserDefault.swift`.

## [0.0.4] - 2024-07-26

### Добавлено

- `CodableUserDefault` — обертка свойств для Codable-типов.

## [0.0.3] - 2024-07-23

### Изменено

- `init(key:defaultValue:container:)` стал `public`.

## [0.0.2] - 2024-07-23

### Добавлено

- `UserDefault` — обертка свойств для `UserDefaults`.

## [0.0.1] - 2022-10-07

### Добавлено

- `UserDefaults.Key<Value>` и subscript'ы для чтения и записи по ключу.
- `UserDefaults.getObjectOrDefault(for:)`.

[Unreleased]: https://github.com/SwiftExtensions/UserDefaultsKit/compare/1.0.0...HEAD
[1.0.0]: https://github.com/SwiftExtensions/UserDefaultsKit/compare/0.0.4...1.0.0
[0.0.4]: https://github.com/SwiftExtensions/UserDefaultsKit/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/SwiftExtensions/UserDefaultsKit/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/SwiftExtensions/UserDefaultsKit/compare/0.0.1...0.0.2
[0.0.1]: https://github.com/SwiftExtensions/UserDefaultsKit/releases/tag/0.0.1
