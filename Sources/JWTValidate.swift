//
//  Validate.swift
//  JWTSwift
//
//  Created by Shayan on 5/25/17.
//
//

import Foundation

enum verificationError : Error {
    case invalidIssuer
    case invalidAudience
    case tokenExpired
}





extension JWT {
    
    public func verify(issuer : String? = nil, audience : String? = nil) throws -> Bool {
        
        let names = JWTClaim.names.self
        
        if claims.verifyDate(id: names.expiration.id, value: Date(), operation: .lowerOrEqual) == .isFalse
        { throw verificationError.tokenExpired }
        
        if claims.verifyEquality(id: names.audience.id, value: audience) == .isFalse
        { throw verificationError.invalidAudience }
        
        if claims.verifyEquality(id: names.issuer.id, value: issuer) == .isFalse
        {  throw verificationError.invalidIssuer }
        
        
        return true
        
    }
    
}
