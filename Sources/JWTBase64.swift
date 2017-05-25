//
//  Base64.swift
//  JWTSwift
//
//  Created by Shayan on 5/24/17.
//
//

import Foundation
func base64encode(_ input: Data) -> String {
    let data = input.base64EncodedData(options: NSData.Base64EncodingOptions(rawValue: 0))
    let string = String(data: data, encoding: .utf8)!
    return string
        .replacingOccurrences(of: "+", with: "-", options: NSString.CompareOptions(rawValue: 0), range: nil)
        .replacingOccurrences(of: "/", with: "_", options: NSString.CompareOptions(rawValue: 0), range: nil)
        .replacingOccurrences(of: "=", with: "", options: NSString.CompareOptions(rawValue: 0), range: nil)
}

/// URI Safe base64 decode
func base64decode(_ input: String) -> Data? {
    let rem = input.characters.count % 4
    
    var ending = ""
    if rem > 0 {
        let amount = 4 - rem
        ending = String(repeating: "=", count: amount)
    }
    
    let base64 = input.replacingOccurrences(of: "-", with: "+", options: NSString.CompareOptions(rawValue: 0), range: nil)
        .replacingOccurrences(of: "_", with: "/", options: NSString.CompareOptions(rawValue: 0), range: nil) + ending
    
    return Data(base64Encoded: base64, options: NSData.Base64DecodingOptions(rawValue: 0))
}

extension String {
    
    /// decodes self from base64 to String
    var fromBase64 : String? {
        guard let data = base64decode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// encodes self from string to base64 string
    var toBase64 : String {
        return base64encode(Data(self.utf8))
    }
}
