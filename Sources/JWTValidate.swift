//
//  Validate.swift
//  JWTSwift
//
//  Created by Shayan on 5/25/17.
//
//

import Foundation

/// verificationErrors
enum verificationError : Error {
    case invalidIssuer
    case invalidAudience
    case tokenExpired
    
    var description : String {
        switch self {
        case .invalidIssuer : return "token contains an invalid issuer"
        case .invalidAudience : return "token contains an invalid audience"
        case .tokenExpired : return "token is expired"
        }
    }
    
}

extension JWT {
    
    
    /// verifies jwt object after generating it from jwtToken
    /// will check the expiration date of the token
    /// - parameter expires : if true, will check expiration date in the claims
    /// - parameter issuer : add issuer if you are expecting the jwt to have an issuer
    /// - parameter audience : add audience if you are expecting the jwt to have an audience
    public func verify(issuer : String? = nil, audience : String? = nil, expires : Bool = true) throws -> Bool {
        
        let names = JWTClaim.names.self
        
        if expires && claims.verifyDate(id: names.expiration.id, value: Date(), operation: .lowerOrEqual) == .isFalse
        { throw verificationError.tokenExpired }
        
        if claims.verifyEquality(id: names.audience.id, value: audience) == .isFalse
        { throw verificationError.invalidAudience }
        
        if claims.verifyEquality(id: names.issuer.id, value: issuer) == .isFalse
        {  throw verificationError.invalidIssuer }
        
        
        return true
        
    }
    
}
