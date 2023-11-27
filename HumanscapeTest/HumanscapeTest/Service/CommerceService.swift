//
//  CommerceService.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//

import Foundation
import Moya
import RxSwift

final class CommerceService: BaseService<CommerceAPI> {
    
    static let shared = CommerceService()
    
    func request<T:Codable>(_ api: CommerceAPI, _ dto: T.Type) -> Single<T> {
        return provider
            .rx
            .request(api)
            .filterSuccessfulStatusCodes()
            .retry(3)
            .map(T.self)
    }
}

enum CommerceAPI {
    case products(query: [String: Any])
    case product(hash: String)
}

extension CommerceAPI: TargetType {
    var baseURL: URL {
        let url = Bundle.main.object(forInfoDictionaryKey: "ServerURL") as! String
        return URL(string: url)!
    }
    
    var path: String {
        switch self {
        case .products:
            return "/rest/shopping/products"
        case .product(let hash):
            return "/rest/shopping/product/\(hash)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .products(let query):
            return .requestParameters(parameters: query, encoding: URLEncoding.default)
        case .product:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return [:]
        }
    }
}
