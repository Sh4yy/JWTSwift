import Foundation
import CryptoSwift

enum cryptoList {
    case none
    case hs256
    case hs384
    case hs512
}


class JWTClaim : JWTStorage {
    
    /// the issuare stored in claim
    /// key value is iss
    var issuer : String? {
        get { return self.storage["iss"] as? String }
        set { self.storage["iss"] = newValue }
    }
    
    /// the expiration date stored in claim
    /// key value is exp
    var expiration : Double? {
        get { return self.storage["exp"] as? Double }
        set { self.storage["exp"] = newValue }
    }
    
    /// the not before stored in claim
    /// key value is nbf
    var notBefore : String? {
        get { return self.storage["nbf"] as? String }
        set { self.storage["nbf"] = newValue }
    }
    
    /// the issued at stored in claim
    /// key value is iat
    var issuedAt : String? {
        get { return self.storage["iat"] as? String }
        set { self.storage["iat"] = newValue }
    }
    
    /// the audience stored in claim
    /// key value is aud
    var audience : String? {
        get { return self.storage["aud"] as? String }
        set { self.storage["aud"] = newValue }
    }
    
}

class JWTHeader : JWTStorage {}

struct JWT {
    
    var header : JWTHeader
    var claims : JWTClaim
    
    init(header : JWTHeader = JWTHeader(),
         claims : JWTClaim = JWTClaim())
    {
        self.header = header
        self.claims = claims
    }
    
    init(header : [String : Any] = [:],
         claims : [String : Any] = [:])
    {
        self.header = JWTHeader(header)
        self.claims = JWTClaim(claims)
    }
    
    
    static func decode(jwt : String, secret : String, algorithm : HMAC.Variant) -> JWT? {
        
        let parts = jwt.components(separatedBy: ".")
        guard parts.count == 3 else { return nil }
        
        guard let header = JWTHeader.init(base64str : parts[0]),
            let claims = JWTClaim.init(base64str : parts[1])
            else { return nil }
        
        let newJWT = JWT(header: header, claims: claims)
        
        return newJWT
        
    }
    
    func signature(algorithm : HMAC.Variant, secret : String) -> String? {
        guard let head64 = header.base64,
            let claim64 = claims.base64
            else { return nil }
        
        let payload = "\(head64).\(claim64)"
        let payloadBytes = [UInt8](payload.utf8)
        
        guard let signature = try? HMAC(key: secret, variant: algorithm)
            .authenticate(payloadBytes).toHexString().toBase64
            else { return nil }
        
        return signature
    
    }
    
    func encode(algorithm : HMAC.Variant, secret : String) -> String? {
        
        guard let head64 = header.base64,
            let claim64 = claims.base64
            else { return nil }
        
        let payload = "\(head64).\(claim64)"
        
        guard let signature = self.signature(algorithm: algorithm, secret: secret)
            else { return nil }
        
        return payload.appending(".").appending(signature)
        
    }
    
    
    

}













