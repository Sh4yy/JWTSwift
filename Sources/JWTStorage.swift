//
//  JWTStorage.swift
//  JWTSwift
//
//  Created by Shayan on 5/24/17.
//
//

import Foundation

/// a boolean with a third case : .neither
enum Toolean {
    case isTrue
    case isFalse
    case neither
}

class JWTStorage {
    
    /// everything will be stored in storage
    var storage : [String : Any]
    
    /// initialize with an dictionary
    init(_ storage : [String : Any]) {
        self.storage = storage }
    
    /// empty initializer
    convenience init() { self.init([:]) }
    
    /// initialize with a json string
    /// - parameter jsonStr : json object in string format
    convenience init?(jsonStr : String) {
        
        guard let data = jsonStr.data(using: .utf8) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data,
            options: .mutableContainers) as? [String : Any] else { return nil }
        
        if let json = json {
            self.init(json)
        } else {
            return nil
        }
        
    }
    
    /// initialize with a json string in base 64
    /// - parameter base64str : json object in base 64 string format
    convenience init?(base64str : String) {
        guard let str = base64str.fromBase64 else { return nil }
        self.init(jsonStr: str)
    }
    
    subscript(_ index : String) -> Any? {
        set { self.storage[index] = newValue }
        get { return storage[index] }
    }
    
    /// returns the value in json string format
    var toString : String? {
        if let data = try? JSONSerialization.data(withJSONObject: storage,
            options: []) { return String(data: data, encoding: .utf8)
        } else { return nil }
    }
    
    /// returns the value in json base64 string format
    var base64 : String? {
        return toString?.toBase64
    }
    
    /// removes evey element from the storage
    func removeAll() {
        storage.removeAll()
    }
    
    /// rmeoves the value associated to key
    /// - parameter key : the key that you are wishing to remove its value
    func removeAt(key : String) {
        storage.removeValue(forKey: key)
    }
    
    /// returns the number of elements in storage
    var count : Int {
        return storage.count
    }
    
    /// set of operations for verifyDate
    enum dateDifference {
        case equal
        case greater
        case greaterOrEqual
        case lower
        case lowerOrEqual
    }
    
    /// verifes a date in storage
    /// - parameter id : the key for the stored date
    /// - parameter value : optional right hand side date value to compare with
    /// - parameter operation : dateDifference operation
    /// - returns : a toolean, .isFalse if does not equal, .isTrue if equals, .neither if does not exist
    func verifyDate(id : String, value : Date? = nil, operation : dateDifference) -> Toolean {
        
        guard let value = value else { return .neither }
        guard let timestamp = self.storage[id] as? Double
            else { return .neither }
        
        let date = Date(timeIntervalSince1970: timestamp)
        
        let difference = value.compare(date).rawValue
        
        switch operation {
        case .equal          : return (difference == 0) ? .isTrue : .isFalse
        case .greater        : return (difference > 0)  ? .isTrue : .isFalse
        case .greaterOrEqual : return (difference >= 0) ? .isTrue : .isFalse
        case .lower          : return (difference < 0)  ? .isTrue : .isFalse
        case .lowerOrEqual   : return (difference <= 0) ? .isTrue : .isFalse
        }
        
    }
    
    /// verifies an equatable value stored in storage
    /// will check to see if two values are ==
    /// - parameter id : the key for the stored value
    /// - parameter value : optional right hand side value for comparison
    /// - returns : a toolean, .isFalse if does not equal, .isTrue if equals, .neither if does not exist
    func verifyEquality<T : Equatable>(id : String, value : T?) -> Toolean {
        
        guard let value = value else { return .neither }
        guard let storageValue = self.storage[id] as? T
            else { return .neither }
        
        return (storageValue == value) ? .isTrue : .isFalse
        
    }
    
}









