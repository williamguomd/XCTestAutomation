//
//  TestDataManager.swift
//  XCTestAutomation
//
//  Utility class for managing test data from JSON files
//

import Foundation

class TestDataManager {
    
    static let shared = TestDataManager()
    
    private var testData: [String: Any] = [:]
    
    private init() {
        loadTestData()
    }
    
    /// Load test data from JSON file
    private func loadTestData() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "testData", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            print("Warning: Could not load testData.json. Using empty test data.")
            return
        }
        
        testData = json
    }
    
    /// Get value from test data by key path (e.g., "users.admin.username")
    func getValue<T>(for keyPath: String, as type: T.Type) -> T? {
        let keys = keyPath.components(separatedBy: ".")
        var current: Any? = testData
        
        for key in keys {
            if let dict = current as? [String: Any] {
                current = dict[key]
            } else {
                return nil
            }
        }
        
        return current as? T
    }
    
    /// Get string value from test data
    func getString(for keyPath: String) -> String? {
        return getValue(for: keyPath, as: String.self)
    }
    
    /// Get integer value from test data
    func getInt(for keyPath: String) -> Int? {
        return getValue(for: keyPath, as: Int.self)
    }
    
    /// Get boolean value from test data
    func getBool(for keyPath: String) -> Bool? {
        return getValue(for: keyPath, as: Bool.self)
    }
    
    /// Get array from test data
    func getArray<T>(for keyPath: String, as type: T.Type) -> [T]? {
        if let array = getValue(for: keyPath, as: [Any].self) {
            return array.compactMap { $0 as? T }
        }
        return nil
    }
    
    /// Get dictionary from test data
    func getDictionary(for keyPath: String) -> [String: Any]? {
        return getValue(for: keyPath, as: [String: Any].self)
    }
    
    /// Get all test data
    func getAllTestData() -> [String: Any] {
        return testData
    }
}


