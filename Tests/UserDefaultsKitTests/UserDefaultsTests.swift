import XCTest
@testable import UserDefaultsKit

final class UserDefaultsTests: XCTestCase {
    var sut: UserDefaults!
    
    override func setUp() {
        super.setUp()
        
        self.sut = UserDefaults(suiteName: "\(Self.self)")
    }
    
    override func tearDown() {
        self.sut.removePersistentDomain(forName: "\(Self.self)")
        
        super.tearDown()
    }
    
    func test_userDefault_save() throws {
        var wrapper = UserDefault<Bool>(
            key: "isEnabledKey",
            defaultValue: false,
            container: self.sut
        )
        
        XCTAssertFalse(wrapper.wrappedValue)
        
        wrapper.wrappedValue = true
        
        XCTAssertTrue(wrapper.wrappedValue)
        XCTAssertTrue(self.sut.bool(forKey: "isEnabledKey"))
    }
    
    func test_userDefault_removeBySettingNil() throws {
        var wrapper = UserDefault<Bool?>(
            key: "isEnabledKey",
            defaultValue: nil,
            container: self.sut
        )
        
        wrapper.wrappedValue = true
        XCTAssertNotNil(self.sut.object(forKey: "isEnabledKey"))
        
        wrapper.wrappedValue = nil
        
        XCTAssertNil(self.sut.object(forKey: "isEnabledKey"))
    }
    
    func test_codableUserDefault_save() throws {
        var wrapper = CodableUserDefault<Person>(
            key: "personKey",
            defaultValue: Person(name: "Alex"),
            container: self.sut
        )
        
        XCTAssertEqual(wrapper.wrappedValue, Person(name: "Alex"))
        
        wrapper.wrappedValue = Person(name: "Bob")
        
        XCTAssertEqual(wrapper.wrappedValue, Person(name: "Bob"))
    }
    
    func test_codableUserDefault_storesPlistTypesNatively() throws {
        var wrapper = CodableUserDefault<Bool>(
            key: "flagKey",
            defaultValue: false,
            container: self.sut
        )
        
        wrapper.wrappedValue = true
        
        XCTAssertTrue(self.sut.bool(forKey: "flagKey"))
    }
    
    func test_codableUserDefault_removeBySettingNil() throws {
        var wrapper = CodableUserDefault<Person?>(
            key: "personKey",
            defaultValue: nil,
            container: self.sut
        )
        
        wrapper.wrappedValue = Person(name: "Alex")
        XCTAssertNotNil(self.sut.object(forKey: "personKey"))
        
        wrapper.wrappedValue = nil
        
        XCTAssertNil(self.sut.object(forKey: "personKey"))
    }
    
    
}

private struct Person: Codable, Equatable {
    let name: String
}
