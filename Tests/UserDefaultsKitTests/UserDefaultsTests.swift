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
    
    func test_save() throws {
        XCTAssertNil(self.sut[.isEnabledKey])
        
        self.sut[.isEnabledKey] = true
        
        XCTAssertNotNil(self.sut[.isEnabledKey])
        XCTAssertTrue(self.sut[.isEnabledKey] == true)
    }
    
    
}

extension UserDefaults.Key {
    static var isEnabledKey: UserDefaults.Key<Bool> {
        UserDefaults.Key(name: "isEnabledKey")
    }
    
    
}
