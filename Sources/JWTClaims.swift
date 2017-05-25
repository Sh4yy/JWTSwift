//
//  JWTClaims.swift
//  JWTSwift
//
//  Created by Shayan on 5/25/17.
//
//

import Foundation

class JWTClaim : JWTStorage {
    
    enum names {
        
        case audience
        case issuedAt
        case notBefore
        case expiration
        case issuer
        case custom(String)
        
        var id : String {
            switch self {
            case .audience   : return "aud"
            case .expiration : return "exp"
            case .issuedAt   : return "iad"
            case .issuer     : return "iss"
            case .notBefore  : return "nbf"
            case .custom(let id) : return id
            }
        }
    }

    
    /// the issuare stored in claim
    /// key value is iss
    var issuer : String? {
        get { return super.storage[names.issuer.id] as? String }
        set { self.storage[names.issuer.id] = newValue }
    }
    
    /// the expiration date stored in claim
    /// key value is exp
    var expiration : Date? {
        get {
            if let timestamp = self.storage[names.expiration.id] as? Double {
                return Date(timeIntervalSince1970: timestamp)
            } else { return nil }
        }
        
        set {
            if let timestamp = newValue?.timeIntervalSince1970 {
                storage[names.expiration.id] = timestamp }
        }
        
    }
    
    /// the not before stored in claim
    /// key value is nbf
    var notBefore : Date? {
        get {
            if let timestamp = self.storage[names.notBefore.id] as? Double {
                return Date(timeIntervalSince1970: timestamp)
            } else { return nil }
        }
        
        set {
            if let timestamp = newValue?.timeIntervalSince1970 {
                storage[names.notBefore.id] = timestamp }
        }
    }
    
    /// the issued at stored in claim
    /// key value is iat
    var issuedAt : Date? {
        get {
            if let timestamp = self.storage[names.issuedAt.id] as? Double {
                return Date(timeIntervalSince1970: timestamp)
            } else { return nil }
        }
        
        set {
            if let timestamp = newValue?.timeIntervalSince1970 {
                storage[names.issuedAt.id] = timestamp }
        }
    }
    
    /// the audience stored in claim
    /// key value is aud
    var audience : String? {
        get { return self.storage[names.audience.id] as? String }
        set { self.storage[names.audience.id] = newValue }
    }
    
    
}

class JWTHeader : JWTStorage {

    /// the algorithm stored in the header
    /// key value is alg
    var algorithm : String? {
        get { return self.storage["alg"] as? String }
        set { self.storage["alg"] = newValue }
    }

    
    /// the type stored in the header
    /// key value is typ
    var type : String? {
        get { return self.storage["typ"] as? String }
        set { self.storage["typ"] = newValue }
    }
    
}
