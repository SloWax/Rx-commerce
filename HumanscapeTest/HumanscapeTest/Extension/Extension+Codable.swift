//
//  Extension+Codable.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/20.
//

import Foundation

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self) else { return nil }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String: Any] else { return nil }
        
        return dictionary
    }
}
