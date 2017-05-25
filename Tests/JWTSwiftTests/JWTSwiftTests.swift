import XCTest
@testable import JWTSwift

class JWTSwiftTests: XCTestCase {
    

    func testToString() {
        
        let claim = JWTClaim()
        claim["int"] = 123
        claim["str"] = "hey"
        claim["bool"] = true
        
        XCTAssertEqual(claim.toString!, "{\"str\":\"hey\",\"bool\":true,\"int\":123}")
        
    }
    
    func testbase64() {
        
        let first = "hi my name is shayan"
        let encoded = first.toBase64
        let decoded = encoded.fromBase64!
        
        print(encoded)
        
        XCTAssert(first == decoded)
        
    }
    
    func testEncode() -> JWT {
        
        let header = JWTHeader.init(jsonStr :
            "{\"version\": \"sha256\",\"alg\": \"HS256\"}")!
        
        let claim = JWTClaim.init(jsonStr :
            "{\"name\": \"shayan\"}")!
        
        let jwt = JWT.init(header: header, claims: claim)
        print(jwt.encode(algorithm: .hs256, secret: "1234")!)
        
        return jwt
        
    }
    
    func testDecode() {
        
        let jwt1 = testEncode()
        
        let jwtcode = jwt1.encode(algorithm: .hs256, secret: "1234")!
        
        let jwt2 = try! JWT.decode(jwt: jwtcode, secret: "1234", algorithm: .hs256)
        
        print(jwt2?.encode(algorithm: .hs256, secret: "1234") == jwtcode)
        
        print("--------")
        
    }
    
    func testCreateJWT() {
        
        
        let jwt = JWT(header: [:], claims: [:])
        
        jwt.claims["name"] = "shayan"
        jwt.claims["lname"] = "taslim"
        
        let jwtToken = jwt.encode(algorithm: .hs256, secret: "token")!
        
        
        let decoded = try! JWT.decode(jwt: jwtToken, secret: "token", algorithm: .hs256)!
        
        XCTAssertTrue(decoded.claims.toString! == jwt.claims.toString!)
        
        XCTAssertTrue(decoded.encode(algorithm: .hs256, secret: "token")! == jwtToken)
        
    }
    
    func testOperands() {
        
        let date1 = Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 10000)
        let date2 = Date(timeIntervalSince1970: Date().timeIntervalSince1970)
        
        let jwt = JWT(header: [:], claims: [:])
        jwt.claims.expiration = date1
        
        print(try! jwt.)
        
    }
    
    static var allTests = [
        ("toString", testToString),
    ]
}
