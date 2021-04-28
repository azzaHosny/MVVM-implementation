//
//  APICaller.swift
//  NetworkFramework
//
//  Created by SmartPan on 4/24/21.
//

import Foundation
import RxSwift
import Alamofire


public protocol JsonEncadable {
    func encodeToJson() -> [String: Any]?
}


public class APICaller<T> where T : Decodable {

    // interceptor -->
    // requestModifier -->
    
   static func makeRequest(url: String, method: HTTPMethod, paramters: [String: Any], header: HTTPHeaders) -> Observable<T> {
        return Observable<T>.create{ observer in
            
            let request = AF.request(url, method: method,
                                     parameters: paramters,
                                     encoding: JSONEncoding.default,
                                     headers: header,
                                     interceptor: nil, requestModifier: nil)
                .responseJSON(completionHandler: { response in
                    do {
                        if let data = response.data {
                            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                            observer.on(.next(decodedResponse))
                        }
                        observer.on(.completed)
                    } catch let error  as NSError {
                        observer.on(.error(error))
                    }
                })
            
            return AnonymousDisposable {
                request.cancel()
            }
        }
    }
}

class AnonymousDisposable : Disposable {
    private let disposeLogic :()->Void
    
    init(_ disposeLogic :@escaping ()->Void) {
        self.disposeLogic = disposeLogic
    }
    func dispose() {
        disposeLogic()
    }
}




//    let headers: [String:String]?
//    let body: JsonEncadable?
//    let urlPathParam: String?
//    let urlQuery: [String: String]?
//    let response: T? = nil
//    let url: String?
//    let method: HTTPMethod
//
//    var fullUrl :String{
//        get{
//            var finalString = url!
//            if let pathParam = urlPathParam {
//                finalString += pathParam
//            }
//            if let urlQuery = urlQuery {
//                finalString += "?"
//
//                urlQuery.forEach{
//                    finalString += "&"
//                  finalString +=  "\($0.key)=\($0.value)"
//                }
//            }
//            return finalString
//        }
//    }
    
//    public init(
//        url: String? = nil,
//        method: HTTPMethod = .get,
//        headers: [String:String]? = nil,
//        body: JsonEncadable? = nil,
//        urlPathParam: String? = nil,
//        urlQuery: [String:String]? = nil
//    ) {
//        self.headers = headers
//        self.body = body
//        self.urlPathParam = urlPathParam
//        self.urlQuery = urlQuery
//        self.url = url
//        self.method = method
//    }
//
