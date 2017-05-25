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
        
        print(header.base64)
        
        let claim = JWTClaim.init(jsonStr :
            "{\"name\": \"shayan\"}")!
        
        let jwt = JWT.init(header: header, claims: claim)
        print(jwt.encode(algorithm: .sha256, secret: "1234")!)
        
        return jwt
        
    }
    
    func testDecode() {
        
        let jwt1 = testEncode()
        
        let jwtcode = jwt1.encode(algorithm: .sha256, secret: "1234")!
        
        let jwt2 = JWT.decode(jwt: jwtcode, secret: "1234", algorithm: .sha256)
        
        print(jwt2?.encode(algorithm: .sha256, secret: "1234") == jwtcode)
        
        print("--------")
        
    }
    
    static var allTests = [
        ("toString", testToString),
    ]
}
