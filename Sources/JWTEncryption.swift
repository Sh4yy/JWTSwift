//
//  JWTEncryption.swift
//  JWTSwift
//
//  Created by Shayan on 5/25/17.
//
//

import Foundation
import CryptoSwift

extension JWT {
    
    
    static func decode(jwt : String, secret : String, algorithm : cryptoList) throws -> JWT? {
        
        let parts = jwt.components(separatedBy: ".")
        guard parts.count == 3 else { return nil }
        
        guard let header = JWTHeader.init(base64str : parts[0]),
            let claims = JWTClaim.init(base64str : parts[1])
            else { return nil }
        
        let newJWT = JWT(header: header, claims: claims)
        
        guard let token = newJWT.encode(algorithm: algorithm, secret: secret),
            token == jwt else { return nil }
        
        return newJWT
        
    }
    
    func signature(algorithm : cryptoList, secret : String) -> String? {
       
        header.type = "JWT"
        header.algorithm = algorithm.description
        
        guard let head64 = header.base64,
            let claim64 = claims.base64
            else { return nil }
        
        let payload = "\(head64).\(claim64)"
        let payloadBytes = [UInt8](payload.utf8)
        
        guard let signature = try? HMAC(key: secret, variant: algorithm.variant)
            .authenticate(payloadBytes).toHexString().toBase64
            else { return nil }
        
        return signature
        
    }
    
    func encode(algorithm : cryptoList, secret : String) -> String? {
        
        guard let head64 = header.base64,
            let claim64 = claims.base64
            else { return nil }
        
        let payload = "\(head64).\(claim64)"
        
        guard let signature = self.signature(algorithm: algorithm, secret: secret)
            else { return nil }
        
        return payload.appending(".").appending(signature)
        
    }
    
}
