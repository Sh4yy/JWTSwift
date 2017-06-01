import Foundation
import CryptoSwift

/// list of available encryption methods
enum cryptoList {
    case hs256
    case hs384
    case hs512
    
    /// retursn the algorithms variant for cryptoSwift
    var variant : HMAC.Variant {
        switch self {
        case .hs256: return .sha256
        case .hs384: return .sha384
        case .hs512: return .sha512
        }
    }
    
    /// returns the algorithm's name in string
    var description : String {
        switch self {
        case .hs256: return "HS256"
        case .hs384: return "HS384"
        case .hs512: return "HS512"
        }
    }
    
}

/// returns an optional cryptoList from a string
/// - parameter value : name of the encryption algorithm in string
/// - returns : an optional cryptoList
func cryptoFinder(_ value : String) -> cryptoList? {
    switch value.uppercased() {
        case "HS256" : return .hs256
        case "HS384": return .hs384
        case "HS512": return .hs512
        default :  return nil
    }
}

struct JWT {
    
    /// header part of the token
    var header : JWTHeader
    
    /// the claims of the token
    var claims : JWTClaim
    
    /// initialize with JWTHeader and JWTClaim
    /// - parameter header : an instance of JWTHeader
    /// - parameter claims : an instance of JWTClaim
    init(header : JWTHeader = JWTHeader(),
         claims : JWTClaim = JWTClaim())
    {
        self.header = header
        self.claims = claims
    }
    
    /// initalize with dictionaries of string and any
    /// - parameter header : a dictionary of [String : Any] as the header
    /// - parameter claims : a dictionary of [String : Any] as the claims
    init(header : [String : Any],
         claims : [String : Any])
    {
        self.header = JWTHeader(header)
        self.claims = JWTClaim(claims)
    }

}












