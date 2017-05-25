import Foundation
import CryptoSwift

enum cryptoList {
    case hs256
    case hs384
    case hs512
    
    var variant : HMAC.Variant {
        switch self {
        case .hs256: return .sha256
        case .hs384: return .sha384
        case .hs512: return .sha512
        }
    }
    
    var description : String {
        switch self {
        case .hs256: return "HS256"
        case .hs384: return "HS384"
        case .hs512: return "HS512"
        }
    }
    
}

func cryptoFinder(_ value : String) -> cryptoList? {
    switch value.uppercased() {
        case "HS256" : return .hs256
        case "HS384": return .hs384
        case "HS512": return .hs512
        default :  return nil
    }
}

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

}



extension JWT {
    
    static func validate(jwt : String) -> Bool {
        
        
        return false
    }
    
    static func validate(jwt : JWT) -> Bool {
        
        
        
        return false
    }
    
}











