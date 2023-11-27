//
//  CommerceDto.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/20.
//

import Foundation

struct CommerceDto: Codable {
    
    struct Request: Codable {
        struct Products: Codable {
            let offset: Int
            let limit: Int
        }
    }
    
    struct Response: Codable {
        struct Products: Codable {
            let meta: Meta
            let products: [Product]
        }
        
        struct Meta: Codable {
            let offset: Int
            let limit: Int
            let isFinal: Bool
        }
        
        struct Product: Codable {
            let hash: String
            let name: String
            let brand: String?
            let sellPrc: Int
            let normalPrc: Int
            let soldOut: Bool
            let imgUrl: String
            let reviewCount: Int
            let reviewAvg: Int
            let partnerNo: Int
            let tags: [String]
            let discountRate: Int
            let deliveryDetail: DeliveryDetail?
            let deliveryAreaDetails: [DeliveryAreaDetail]?
        }
        
        struct DeliveryDetail: Codable {
            let isFree: Bool
            let freeLimit: Int
            let deliveryFee: Int
            let isBillingByAreaWhenFree: Bool
            let basedBy: String
        }
        
        struct DeliveryAreaDetail: Codable {
            let sido: String
            let gugun: String
            let dong: String
            let addPrice: Int
        }
    }
}
