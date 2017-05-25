//
//  JWTStorage.swift
//  JWTSwift
//
//  Created by Shayan on 5/24/17.
//
//

import Foundation

enum Toolean {
    case isTrue
    case isFalse
    case neither
}

class JWTStorage {
    
    var storage : [String : Any]
    
    init(_ storage : [String : Any]) {
        self.storage = storage }
    convenience init() { self.init([:]) }
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
    convenience init?(base64str : String) {
        guard let str = base64str.fromBase64 else { return nil }
        self.init(jsonStr: str)
    }
    
    subscript(_ index : String) -> Any? {
        set { self.storage[index] = newValue }
        get { return storage[index] }
    }
    
    var toString : String? {
        if let data = try? JSONSerialization.data(withJSONObject: storage,
            options: []) { return String(data: data, encoding: .utf8)
        } else { return nil }
    }
    
    var base64 : String? {
        return toString?.toBase64
    }
    
    func removeAll() {
        storage.removeAll()
    }
    
    func removeAt(key : String) {
        storage.removeValue(forKey: key)
    }
    
    var count : Int {
        return storage.count
    }
    
    enum dateDifference {
        case equal
        case greater
        case greaterOrEqual
        case lower
        case lowerOrEqual
    }
    
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
    
    func verifyEquality<T : Equatable>(id : String, value : T?) -> Toolean {
        
        guard let value = value else { return .neither }
        guard let storageValue = self.storage[id] as? T
            else { return .neither }
        
        return (storageValue == value) ? .isTrue : .isFalse
        
    }
    
}
