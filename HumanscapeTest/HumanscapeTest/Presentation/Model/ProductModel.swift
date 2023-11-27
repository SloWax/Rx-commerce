//
//  ProductModel.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/20.
//

import Foundation

struct ProductModel {
    let hash: String
    let brand: String
    let name: String
    let normalPrc: Int
    let sellPrc: Int
    let price: Int
    let imgUrl: String
    let reviewAvg: Int
    let reviewCount: Int
    let tags: [String]
    
    func discountRate() -> Int {
        guard normalPrc > sellPrc else { return 0 }
        
        let discount = normalPrc - sellPrc
        let result = Double(discount) / Double(normalPrc) * 100
        
        return Int(result)
    }
}
