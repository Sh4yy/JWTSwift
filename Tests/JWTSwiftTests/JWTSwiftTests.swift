import XCTest
@testable import JWTSwift
@testable import CryptoSwift

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
    
    func testCycle() {
        
        let jwt = JWT(header: [:], claims: [:])
        jwt.claims.expiration = Date().addingTimeInterval(1000)
        jwt.claims.issuer = "shayan"
        
        let jwtToken = jwt.encode(algorithm: .hs512, secret: "this is my token")!
        
        let jwtDecoded = try! JWT.decode(jwt: jwtToken, secret: "this is my token", algorithm: .hs512)!
        
        do {
            print(try jwtDecoded.verify(issuer: "shayan"))
            print("we made it :D")
        } catch (let error) {
            print("error \(error)")
        }
        
        
        
    }
    
    func testOperands() {
        
        let date1 = Date(timeIntervalSince1970: Date().timeIntervalSince1970 + 1)

        let jwt = JWT(header: [:], claims: [:])
        jwt.claims.expiration = date1
        
        do {
            print(try jwt.verify())
        } catch (let error) {
            print("\(error)")
        }
        
    }
    
    static var allTests = [
        ("toString", testToString),
    ]
}
