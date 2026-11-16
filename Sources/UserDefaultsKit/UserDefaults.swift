//
//  UserDefaults.swift
//  UserDefaultsKit
//

import Foundation

extension UserDefaults {
    private static let decoder = JSONDecoder()
    private static let encoder = JSONEncoder()
    
    /**
     Читает и декодирует значение по ключу.
     Значения, сохраненные как property-list объекты, возвращаются напрямую,
     остальные декодируются из JSON.
     - Parameter forKey: Ключ хранения в пользовательской базе данных.
     */
    func decodableObject<T>(forKey: String) -> T? where T: Decodable {
        guard let stored = self.object(forKey: forKey) else { return nil }
        if let value = stored as? T {
            return value
        }
        guard let data = stored as? Data else { return nil }
        do {
            return try Self.decoder.decode(T.self, from: data)
        } catch {
            assertionFailure("Не удалось декодировать значение по ключу \(forKey): \(error)")
            return nil
        }
    }
    
    /**
     Сохраняет значение по ключу.
     Property-list типы (`String`, `Bool`, числа, `Date`, `Data`, коллекции из них)
     сохраняются нативно, остальные кодируются в JSON.
     - Parameter value: Значение для сохранения.
     - Parameter forKey: Ключ хранения в пользовательской базе данных.
     */
    func setEncodable<T>(_ value: T, forKey: String) where T: Encodable {
        if PropertyListSerialization.propertyList(value, isValidFor: .binary) {
            self.set(value, forKey: forKey)
            return
        }
        do {
            self.set(try Self.encoder.encode(value), forKey: forKey)
        } catch {
            assertionFailure("Не удалось закодировать значение по ключу \(forKey): \(error)")
        }
    }
        
}
