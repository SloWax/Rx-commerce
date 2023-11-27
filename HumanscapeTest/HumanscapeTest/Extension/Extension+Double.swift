//
//  Extension+Double.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/23.
//

import Foundation

extension Double {
    func calcurate(fraction numerator: Int, _ denominator: Int) -> Double {
        guard numerator > denominator else { return 0 }
        
        let discount = numerator - denominator
        
        return Double(discount) / Double(numerator) * 100
    }
}
