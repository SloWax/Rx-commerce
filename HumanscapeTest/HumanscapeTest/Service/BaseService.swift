//
//  BaseService.swift
//  HumanscapeTest
//
//  Created by 표건욱 on 2023/10/19.
//

import Foundation
import Moya
import RxSwift

class BaseService<API: TargetType> {
    
    lazy var provider: MoyaProvider<API> = {
        let session = Session(interceptor: Interceptor.shared)
        
        return .init(session: session, plugins: plugins)
    }()
    
    lazy var plugins: [PluginType] = {
        #if DEBUG
        return [RequestLoggingPlugin(), NetworkActivityPlugin(networkActivityClosure: networkClosure)]
        #else
        return [NetworkActivityPlugin(networkActivityClosure: networkClosure)]
        #endif
    }()
    
    var networkClosure: (NetworkActivityChangeType, TargetType) -> () {
        return {(_ change: NetworkActivityChangeType, _ target: TargetType) in
            switch change {
            case .began:
                DispatchQueue.main.async {
                    // Indicator Start
                }
            case .ended:
                DispatchQueue.main.async {
                    // Indicator Stop
                }
            }
        }
    }
}

final class RequestLoggingPlugin: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        guard let httpRequest = request.request else { return print("--> invalid request") }
        
        let url = httpRequest.description
        let method = httpRequest.httpMethod ?? "unknown method"
        
        var log = "🔵 --> \(method) \(url)\n"
        log.append("🟠 API: \(target) \(url)\n")
        
        if let headers = httpRequest.allHTTPHeaderFields, !headers.isEmpty {
            log.append("🟠 header: \(headers)\n")
        }
        
        if let body = httpRequest.httpBody, let bodyString = String(bytes: body, encoding: String.Encoding.utf8) {
            log.append("\(bodyString)\n")
        }
        
        log.append("--> END \(method)")
        print(log)
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            onSuceed(response, target: target, isFromError: false)
        case let .failure(error):
            print("here >> 🥵🥵🥵🥵🥵🥵🥵🥵🥵")
            onFail(error, target: target)
        }
    }
    
    private func onSuceed(_ response: Response, target: TargetType, isFromError: Bool) {
        let request = response.request
        let url = request?.url?.absoluteString ?? "nil"
        let statusCode = response.statusCode
        
        var log = "<-- \(statusCode) \(url)\n"
        log.append("API: \(target)\n")
        
        response.response?.allHeaderFields.forEach {
            log.append("\($0): \($1)\n")
        }
        
        if let reString = String(bytes: response.data, encoding: String.Encoding.utf8) {
            log.append("\(reString)\n")
        }
        
        log.append("<-- END HTTP (\(response.data.count)-byte body)")
        print(log)
    }
    
    private func onFail(_ error: MoyaError, target: TargetType) {
        if let response = error.response {
            onSuceed(response, target: target, isFromError: true)
            return
        }
        
        var log = "<-- \(error.errorCode) \(target)\n"
        log.append("\(error.failureReason ?? error.errorDescription ?? "unknown error")\n")
        log.append("<-- END HTTP")
        print(log)
        
        print("🥵🥵🥵🥵🥵🥵🥵🥵🥵")
    }
}

final class Interceptor: RequestInterceptor {
    
    static let shared = Interceptor()
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        if let mutableRequest = (urlRequest as NSURLRequest).mutableCopy() as? NSMutableURLRequest {
            
            let key = Bundle.main.object(forInfoDictionaryKey: "authorization") as! String
            var headers: [String: String] = [
                "authorization": key,
                "Content-Type": "application/json"
            ]
            
            if let mutableHeaders = mutableRequest.allHTTPHeaderFields {
                headers.merge(mutableHeaders) { $1 }
            }
            
            mutableRequest.allHTTPHeaderFields = headers
            
            completion(.success(mutableRequest as URLRequest))
            return
        }
        
        completion(.success(urlRequest))
    }
}
