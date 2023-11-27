//
//  Extension+Int.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/20.
//

import Foundation

extension Int {
    var comma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: self as NSNumber) ?? ""
    }
}
