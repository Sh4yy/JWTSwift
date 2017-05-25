//
//  JWTStorage.swift
//  JWTSwift
//
//  Created by Shayan on 5/24/17.
//
//

import Foundation

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
    
}
